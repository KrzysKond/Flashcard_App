import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_test5/data/languages.dart';
import 'package:flashcard_test5/models/screen_arguments.dart';


class LanguageScreen extends StatefulWidget {

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    int args =  ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back, size: 55,color: Colors.black,)),
              ),
              Center(
                child: Material(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/${countries[args-1]}.png'),
                    radius: 85,
                  ),
                  elevation: 18.0,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                ),
              ),
              const SizedBox(height: 30),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('categories')
                  .where(('language'), isEqualTo: countries[args-1])
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot){
                    if(!snapshot.hasData){
                      return const CircularProgressIndicator();
                    }
                      return GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        children: List.generate(
                            snapshot.data.docs.length, (index) {
                          return Padding(
                              padding: const EdgeInsets.all(6),
                                          child: Material(
                                            child: InkWell(
                                              child:Container(
                                                child: Center(
                                                    child: Text(
                                                      snapshot.data.docs[index]['category'],
                                                      style: const TextStyle(
                                                        fontFamily: 'NotoSans',
                                                        fontSize: 20 ,
                                                        color: Colors.white,
                                                      ),
                                                    )),
                                                decoration: BoxDecoration(
                                                  color: Colors.blueAccent[700],
                                                  borderRadius: BorderRadius.circular(22),
                                                ),
                                              ),

                                              onTap: () {
                                                Navigator.pushNamed(context, '/flashcards', arguments:
                                                ScreenArguments(
                                                    snapshot.data!.docs[index].id, snapshot.data!.docs[index]['category'].toString())
                                                  );
                                              },
                                            ),
                                          ),

                                  //  ),

                          );
                        }),
                      );
              },
            ),
            ],
          ),
        ),
      ),
    );
  }
}
