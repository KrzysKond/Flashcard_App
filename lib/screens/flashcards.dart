import 'package:flashcard_test5/models/screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final userRf= FirebaseFirestore.instance.collection('categories');



class Flashcards extends StatefulWidget {
  const Flashcards({Key? key}) : super(key: key);

  @override
  _FlashcardsState createState() => _FlashcardsState();
}

class _FlashcardsState extends State<Flashcards> {
  @override
  Widget build(BuildContext context) {
    final arguments =  ModalRoute.of(context)!.settings.arguments as ScreenArguments ;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                      child: const Icon(
                        Icons.arrow_back, size: 55, color: Colors.black,)),
                ),
                const SizedBox(
                  height: 20,
                ),
                 Center(
                   child: Text(
                     '${arguments.name} Flashcards',
                    style: const TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 37 ,
                      fontWeight: FontWeight.w400,
                    ),
                ),
                 ),
                const SizedBox(height: 50),
                Container(
                  height: 150,
                  width: 190,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent[700],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/play', arguments: arguments);
                    },
                    icon: const Icon(
                      Icons.play_arrow, color: Colors.white, size: 70,),
                    label: const Text('Play',
                      style: TextStyle(color: Colors.white, fontSize: 40),),
                  ),
                ),
                const SizedBox(height: 30),
                StreamBuilder(
                  stream: FirebaseFirestore
                      .instance
                      .collection('categories')
                      .doc(arguments.docID)
                      .collection('Flashcards')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot){
                    if(!snapshot.hasData){
                      return const CircularProgressIndicator();
                    }
                    else{
                      return  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index){
                                return SizedBox(
                                  height: 60,
                                  child: Card(
                                    color: Colors.blueAccent[700],
                                    elevation: 0,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: width/10,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                            child: Text(
                                              snapshot.data.docs[index]['word'],
                                              style: const  TextStyle(
                                                  fontFamily: 'NotoSans',
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: width/10,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                            child: Text(
                                              snapshot.data.docs[index]['translation'],
                                              style: const  TextStyle(
                                                  fontFamily: 'NotoSans',
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ),
                                );
                              }
                          ),
                      );
                    }
                  },
                )
              ],
            ),
        ),
      ),
    );
  }
}
