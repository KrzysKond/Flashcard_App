import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcard_test5/screens/flashcards.dart';
import 'package:flashcard_test5/screens/language_screen.dart';
import 'package:flashcard_test5/screens/home.dart';
import 'package:flashcard_test5/screens/log_in.dart';
import 'package:flashcard_test5/screens/play.dart';
import 'package:flashcard_test5/screens/reset.dart';
import 'package:flashcard_test5/screens/sign_up.dart';
import 'package:flashcard_test5/screens/verification.dart';
import 'package:flashcard_test5/screens/wrapper.dart';
import 'package:flashcard_test5/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
          StreamProvider<User?>.value(
        value: FirebaseAuth.instance.authStateChanges(),
        initialData: FirebaseAuth.instance.currentUser,
          ),
        ],
        child: MaterialApp(
                debugShowCheckedModeBanner: false,
                routes: {
                  '/home': (context) => Home(),
                  '/languageScreen': (context) => LanguageScreen(),
                  '/flashcards': (context) => Flashcards(),
                  '/play': (context) => Play(),
                  '/login': (context) => LogIn(),
                  '/signup': (context) => SignUp(),
                  '/verify':(context)=>Verification(),
                  '/reset':(context)=>Reset(),
                  '/wrapper':(context)=>Wrapper(),
                },
                home:FutureBuilder(
                  future: Firebase.initializeApp(),
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      return Scaffold(body: SafeArea(
                          child: Text('Something went wrong ${snapshot.error.toString()}', style: const TextStyle(fontSize: 40),)));
                    }
                    else if(snapshot.hasData){
                        return  Wrapper();

                    }
                    else{
                      return const CircularProgressIndicator();
                    }
                  },
                ),
        ),
    );
  }
}
