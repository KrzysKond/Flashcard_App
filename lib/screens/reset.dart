import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);

  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  String? _email;
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, size: 55,color: Colors.black, ),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                    child: Text(
                        'Enter your email to reset your password',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'NotoSans',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [AutofillHints.email],
                    onChanged: (value) {
                       _email = value.trim();
                    } ,
                    decoration: const InputDecoration(
                      hintText: 'email'
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      height: 70,
                      width: 170,
                      child: ElevatedButton(
                        onPressed: (){
                          if(_email!=null) {

                            FirebaseAuth.instance.sendPasswordResetEmail(email: _email.toString(),);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.blueAccent[700],
                                  content: const Text(
                                    'We have send you an email',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                            );
                            Navigator.pop(context);

                          }
                          else{
                            setState(() {
                              error='Please enter some text';
                            });
                          }

                        },
                        child: const Text(
                          'Send request',
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
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
