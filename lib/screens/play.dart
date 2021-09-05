import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_test5/models/screen_arguments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

class Play extends StatefulWidget {
  const Play({Key? key}) : super(key: key);
  @override
  _PlayState createState() => _PlayState();
}

int length = 0;
class _PlayState extends State<Play> {
  List<int> newIndex=[];
  int index =0;
  @override
  Widget build(BuildContext context) {
    final arguments =  ModalRoute.of(context)!.settings.arguments as ScreenArguments ;
    Future<dynamic> getData()async{
      final QuerySnapshot qSnap = await FirebaseFirestore.instance.collection('categories').doc(arguments.docID).collection('Flashcards').get();
      final int theLength = qSnap.docs.length;
      if(newIndex.isEmpty){
        for(int i=0; i<theLength; i++){
          setState(() {
            newIndex.add(i);
          });
        }
        setState(() {
          newIndex.shuffle();
        });
      }
    }
    getData();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back, size: 55, color: Colors.black),
                ),
              ),
             const SizedBox(
               height: 100,
             ),
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
                    return Column(
                      children: [
                        Center(
                          child: SizedBox(
                              height: 300,
                              width: 300,
                           child: FlipCard(
                             key: cardKey,
                              direction: FlipDirection.VERTICAL,
                              front: Card(
                                color: Colors.blueAccent[700],
                                elevation: 4,
                                  child: Center(
                                      child: Text(
                                        snapshot.data.docs[newIndex[index]]['translation'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 35,
                                        ),
                                      ),
                                  ),
                              ),
                              back: Card(
                                color: Colors.blueAccent[700],
                                elevation: 4,
                                  child: Center(
                                      child: Text(
                                        snapshot.data.docs[newIndex[index]]['word'],
                                          textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 35,
                                        ),
                                      ),
                                  ),
                              ),
                            ),
                          ),
                        ),


              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 150.0,
                    height: 70.0,
                    child: OutlinedButton.icon(
                        onPressed: (){
                          if(index>0) {
                            setState(() {
                              if(cardKey.currentState!.isFront==false){
                                cardKey.currentState!.toggleCard();
                                cardKey.currentState!.controller!.reset();
                                index--;
                              }else{
                                index--;
                              }

                            });
                          }
                        },
                        icon: const Icon(Icons.chevron_left),
                        label: const Text(
                            'Prev',
                          style: TextStyle(
                            fontSize: 27,
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 150.0,
                    height: 70.0,
                    child: OutlinedButton.icon(
                        onPressed: (){
                          if(snapshot.data.docs.length-1>index) {
                            setState(() {
                              if(cardKey.currentState!.isFront==false){
                                cardKey.currentState!.toggleCard();
                                cardKey.currentState!.controller!.reset();
                                index++;
                              }else{
                                index++;
                              }
                            });
                          }
                        },
                        icon: const Icon(Icons.chevron_right),
                        label: const Text(
                          'Next',
                          style:  TextStyle(
                            fontSize: 27,
                          ),
                        )),
                  ),
                ],
              ),
                      ],
                    );
                  }
                  ),
            ]
          ),
        ),
      ),
    );
  }
}
