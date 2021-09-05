import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  User? user;
  Timer? timer;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    user!.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }
  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
               Text(
                'Verify your email',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'NotoSans',
                  color: Colors.blueAccent[700],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
               Padding(
                  padding: const EdgeInsets.fromLTRB(15,30,15,0),
                  child: Text(
                    'An email has been sent to ${user!.email} please verify, after verifying wait please it might take few seconds',
                    style:  const TextStyle(
                      fontSize: 20,
                      fontFamily: 'NotoSans',
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> checkEmailVerified() async {
    user = FirebaseAuth.instance.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      timer!.cancel();
      Navigator.pushReplacementNamed(context, '/wrapper');
  }
}
}
