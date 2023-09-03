// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 22,
              ),
              Text(
                "Username: ${data['username']}",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Text(
                "Email: ${data['email']}",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Text(
                "Password: ${data['pass']}",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Text(
                "Age: ${data['age']} years old",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Text(
                "Title: ${data['title']} ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}