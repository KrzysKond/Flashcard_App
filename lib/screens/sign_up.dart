import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcard_test5/services/auth.dart';
import 'package:flutter/material.dart';

var _formKey = GlobalKey<FormState>();
String? password;
String? email;
String? repeatPassword;


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
    String error = '';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Center(
                    child: Text(
                      'Sign up',
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
                      autofillHints: [AutofillHints.email],
                      maxLines: null,
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
                  const SizedBox(
                    height: 50,
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
                  const SizedBox(height: 50),
                  SizedBox(
                    width: width/1.3,
                    child: const Text(
                      'repeat your password',
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
                        hintText: 'Enter your password once again',
                      ),
                      obscureText: true,
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if(value!=password){
                          return 'Passwords are not the same';
                        }
                        return null;
                      },
                      onSaved: (value){
                        setState(() {
                          repeatPassword=value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 70,
                    width: 170,
                    child: ElevatedButton(
                      onPressed: (){
                        _formKey.currentState!.save();
                       if(_formKey.currentState!.validate()) {
                         AuthenticationService(FirebaseAuth.instance).signUp(
                             email: email!, password: password!);
                         FirebaseAuth.instance
                             .userChanges()
                             .listen((User? user) {
                           if (user == null) {
                           const CircularProgressIndicator();
                           } else {
                             Navigator.pushReplacementNamed(context, '/verify');
                             ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.blueAccent[700],
                                 content: const Text(
                                     'You have successfully signed up! Please verify your email',
                                   style: TextStyle(
                                     fontSize: 18,
                                     color: Colors.white
                                   ),
                                 ),
                               ),
                             );
                           }
                         });
                       }
                       else{
                         setState(() {
                           error = 'Could not sign up with those credentials';
                         });
                       }
                      },
                      child: const Text(
                        'Sign up',
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
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blueAccent[700]),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                          ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                ],
              ),
            ),
          ),
        ),
    );
  }
}
