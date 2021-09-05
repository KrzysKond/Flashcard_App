import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcard_test5/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_test5/data/languages.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            TextButton.icon(
                onPressed: () async {
                  await AuthenticationService(FirebaseAuth.instance).signOut();
                },
                icon: Icon(Icons.logout, size: 60, color: Colors.blueAccent[700]),
                label: Text(
                    'Sign out',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blueAccent[700],
                  ),
                ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: countries.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                // return header(width);
                return Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Icon(
                          Icons.person, size: 50, color: Colors.blueAccent[700]),
                      ),

                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          'Hello!',
                          style: TextStyle(
                            fontSize: 80,

                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 9),
                      child: const Divider(
                        color: Colors.blueAccent,
                        height: 30,
                      ),
                    ),
                  ],
                );
              }
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, '/languageScreen', arguments: index);
                },
                child: AbsorbPointer(
                  absorbing: true,
                  child: SizedBox(
                    width: width,
                    height: 100,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Material(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage(
                                  'assets/${countries[index - 1]}.png',),
                              ),
                              elevation: 18.0,
                              shape: const CircleBorder(),
                              clipBehavior: Clip.antiAlias,
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              countries[index - 1],
                              style: const TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 23,
                                  fontWeight: FontWeight.w300
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}