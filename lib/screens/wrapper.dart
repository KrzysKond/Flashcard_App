import 'package:flashcard_test5/screens/home.dart';
import 'package:flashcard_test5/screens/log_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    User? user = context.watch<User?>();
       if(user!=null ){
         user.reload();
        return Home();
      }
       else{
         return const LogIn();
       }

  }
}
