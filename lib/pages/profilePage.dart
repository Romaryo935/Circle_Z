import 'package:circle_z/shared/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final credential = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BTNgreen,
        title: const Text('profile page'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: GetDataFromFirestore(documentId: credential!.uid)),
    );
  }
}

class GetDataFromFirestore extends StatelessWidget {
  final String documentId;

  const GetDataFromFirestore({Key? key, required this.documentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('userSSS');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return

              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     SizedBox(
              //       height: 22,
              //     ),
              //     Text(
              //       "Username: ${data['username']}",
              //       style: TextStyle(
              //         fontSize: 17,
              //       ),
              //     ),
              //     SizedBox(
              //       height: 22,
              //     ),
              //     Text(
              //       "Email: ${data['email']}",
              //       style: TextStyle(
              //         fontSize: 17,
              //       ),
              //     ),
              //     SizedBox(
              //       height: 22,
              //     ),
              //     Text(
              //       "Password: ${data['pass']}",
              //       style: TextStyle(
              //         fontSize: 17,
              //       ),
              //     ),
              //     SizedBox(
              //       height: 22,
              //     ),
              //     Text(
              //       "Age: ${data['age']} years old",
              //       style: TextStyle(
              //         fontSize: 17,
              //       ),
              //     ),
              //     SizedBox(
              //       height: 22,
              //     ),
              //     Text(
              //       "Title: ${data['title']} ",
              //       style: TextStyle(
              //         fontSize: 17,
              //       ),
              //     ),
              //   ],
              // );
              Column(
            children: [
              const SizedBox(height: 40),
              const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/img/ali.jpg'),
              ),
              const SizedBox(height: 20),
              itemProfile('Name', data['username'], CupertinoIcons.person),
              const SizedBox(height: 10),
              itemProfile('Title', data['title'], CupertinoIcons.person_2),
              const SizedBox(height: 10),
              itemProfile('age', data['age'], CupertinoIcons.location),
              const SizedBox(height: 10),
              itemProfile('Email', data['email'], CupertinoIcons.mail),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {

                      showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11)),
                    child: Container(
                      padding: const EdgeInsets.all(22),
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TextField(
                              // controller: myController,
                              maxLength: 20,
                              decoration:
                                  InputDecoration(hintText: "Add new Task")),
                          const SizedBox(
                            height: 22,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "ADD",
                                style: TextStyle(fontSize: 22),
                              ))
                        ],
                      ),
                    ),
                  );
                },
              );
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        backgroundColor: BTNgreen),
                    child: const Text('Edit Profile')),
              )
            ],
          );
        }

        return const Text("loading");
      },
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
   
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  color: Colors.deepOrange.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 10)
            ]),
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(iconData),
          trailing:
               Icon(Icons.arrow_forward, color: Colors.grey.shade400),
          //     IconButton(
          //   iconSize: 72,
          //   icon: const Icon(Icons.favorite),
          //   onPressed: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return Dialog(
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(11)),
          //           child: Container(
          //             padding: const EdgeInsets.all(22),
          //             height: 200,
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 const TextField(
          //                     // controller: myController,
          //                     maxLength: 20,
          //                     decoration:
          //                         InputDecoration(hintText: "Add new Task")),
          //                 const SizedBox(
          //                   height: 22,
          //                 ),
          //                 TextButton(
          //                     onPressed: () {
          //                       Navigator.pop(context);
          //                     },
          //                     child: const Text(
          //                       "ADD",
          //                       style: TextStyle(fontSize: 22),
          //                     ))
          //               ],
          //             ),
          //           ),
          //         );
          //       },
          //     );
          //   },
          // ),
          tileColor: Colors.white,
        ),
      );

  }
}
