import 'package:circle_z/pages/forgot_pass.dart';
import 'package:circle_z/pages/login.dart';
import 'package:circle_z/shared/colors.dart';
import 'package:circle_z/shared/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isVisable = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final titleController = TextEditingController();

  register() async {
    setState(() {
      isLoading = true;
    });

    try {
       final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );



            print(credential.user!.uid);

      CollectionReference users =
          FirebaseFirestore.instance.collection('userSSS');

      users
          .doc(credential.user!.uid)
          .set({
            'username': usernameController.text,
            'age': ageController.text,
            "title": titleController.text,
            "email": emailController.text,
            "pass": passController.text,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
      // if (!mounted) return;
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const Homeee()),
      // );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "The account already exists for that email.");
      } else {
        showSnackBar(context, "ERROR- PLEASE TRY AGAIN LATER");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BTNgreen,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sign up'.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                  Text('Register to continue',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white54))
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    const SizedBox(height: 20),


                                        Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 5),
                                color: BTNgreen.withOpacity(.2),
                                spreadRadius: 5,
                                blurRadius: 10)
                          ]),
                      child: TextFormField(
                           controller: usernameController,
                       keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.person),
                            hintText: 'Enter Your Name',
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(height: 15),



                                        Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 5),
                                color: BTNgreen.withOpacity(.2),
                                spreadRadius: 5,
                                blurRadius: 10)
                          ]),
                      child: TextFormField(
                                controller: ageController,
                      keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.person_2),
                            hintText: 'Enter Your Age',
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(height: 15),




                                        Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 5),
                                color: BTNgreen.withOpacity(.2),
                                spreadRadius: 5,
                                blurRadius: 10)
                          ]),
                      child: TextFormField(
                          controller: titleController,
                      keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.title),
                            hintText: 'Enter Your Title',
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(height: 15),




                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 5),
                                color: BTNgreen.withOpacity(.2),
                                spreadRadius: 5,
                                blurRadius: 10)
                          ]),
                      child: TextFormField(
                        controller: emailController,
                       validator: (value) {return value != null && !EmailValidator.validate(value) ? "Enter a valid email" : null;},
                         autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.email),
                            hintText: 'Email',
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 5),
                                color: BTNgreen.withOpacity(.2),
                                spreadRadius: 5,
                                blurRadius: 10)
                          ]),
                      child: TextFormField(
                        controller: passController,
                        obscureText: isVisable ? true : false,
                        validator: (value) {
                          return value!.length < 8
                              ? "Enter at least 6 characters"
                              : null;
                        },
                         autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisable = !isVisable;
                                });
                              },
                              icon: isVisable
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 5),
                                color: BTNgreen.withOpacity(.2),
                                spreadRadius: 5,
                                blurRadius: 10)
                          ]),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisable = !isVisable;
                                });
                              },
                              icon: isVisable
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()),
                            );
                          },
                          child: const Text('Forgot password?')),
                    ),
                    const SizedBox(height: 10),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     if (_formKey.currentState!.validate()) {
                    //       await register();
                    //       if (!mounted) return;
                    //       Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => const LoginScreen()),
                    //       );
                    //     } else {
                    //       showSnackBar(context, "ERROR");
                    //     }
                    //   },

                    //   style: ElevatedButton.styleFrom(
                    //       backgroundColor: BTNgreen,
                    //       padding: const EdgeInsets.all(15)),
                    //   child: const Text('Sign up'),
                    // ),

                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await register();
                          if (!mounted) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        } else {
                          showSnackBar(context, "ERROR");
                        }
                      },
                      color: BTNgreen,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Register",
                              style: TextStyle(fontSize: 19),
                            ),
                    ),

                    const SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const Text("Don't Have an account?"),
                    //     TextButton(onPressed: () {}, child: const Text('Create account'))
                    //   ],
                    // )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
