import 'package:flashcard_test5/shared/loading.dart';
import 'package:flashcard_test5/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

var _formKey = GlobalKey<FormState>();
String? password;
String? email;

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool loading = false;
  String error = '';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return loading ? const Loading() : Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:  Column(
                children: [
                const  SizedBox(
                    height: 50,
                  ),
                 const Center(
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 60,
                      ),
                    ),
                  ),
                const  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: width/1.3,
                    child: const Text(
                      'email',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width/1.3,
                    child: TextFormField(
                      decoration: const  InputDecoration(
                        hintText: 'Your email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      maxLines: null,
                      autofillHints: [AutofillHints.email],
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value){
                        setState(() {
                          email=value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                   height: 50,
                    child: Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ),
            SizedBox(
              width: width/1.3,
              child: const Text(
                'password',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(
              width: width/1.3,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Your password',
                ),
                obscureText: true,
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value){
                  setState(() {
                    password=value;
                  });
                },
              ),
            ),

                 SizedBox(
                      height: 20,
                    child: Center(
                      child: Text(
                        error,
                        style: const TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 55,
                      child: TextButton(
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Colors.blueAccent[700],
                            fontSize: 17
                          ),
                        ),
                        onPressed: (){
                          Navigator.pushNamed(context, '/reset');
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: 170,
                    child: ElevatedButton(
                      onPressed: () async{
                        _formKey.currentState!.save();
                        if(_formKey.currentState!.validate()){
                          setState(() => loading = true);
                          await AuthenticationService(FirebaseAuth.instance).signIn(email: email!, password: password!);
                          User? user = FirebaseAuth.instance.currentUser;
                            if(user!=null&&user.emailVerified==true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.blueAccent[700],
                                  content: const Text(
                                    'You have successfully signed in!',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              );
                            }
                          else{
                            setState(() {
                              error='No user has been found with these credentials';
                              loading=false;
                            });
                          }
                        }
                      },
                      child: const Text(
                          'Log in',
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blueAccent[700]),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                              )
                          )
                      ),
                    ),
                  ),
                  const SizedBox(
                    height:60,
                    child: Center(
                        child: Text(
                            'or',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                    ),
                  ),
                  
                  SizedBox(
                    height: 70,
                    width: 170,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                      child: const Text(
                          'Sign up',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blueAccent[700]),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )
                          )
                      ),
                    ),
                  ),
                ],
              ),

          ),
        ),
      ),
    );
  }
}
