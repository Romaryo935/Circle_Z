import 'package:circle_z/pages/home.dart';
import 'package:circle_z/pages/login.dart';
import 'package:circle_z/provider/cart.dart';
import 'package:circle_z/shared/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

 Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
 }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return Cart();
      },
      child:  MaterialApp(
    home: StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {return const Center(child: CircularProgressIndicator(color: Colors.white,));} 
      else if (snapshot.hasError) {return showSnackBar(context, "Something went wrong");}
      else if (snapshot.hasData) {return  Home();}
      else { return const LoginScreen();}
    },
 ),
 ),
    );
  }
}
