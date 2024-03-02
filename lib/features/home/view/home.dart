import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:paypie/features/auth/view/auth_phone_otp.dart';

import '../../../constants/degine_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Home Page",
            style: TextStyle(
              fontSize: LARGE_FONT_SIZE,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then(
                  (value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PhoneLogin(),
                        ),
                        (route) => false);
                  },
                );
              },
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            )
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                String firstName = snapshot.data!.docs[index]["firstName"];
                String lastName = snapshot.data!.docs[index]["lastName"];
                String email = snapshot.data!.docs[index]["email"];
                String phoneNumber = snapshot.data!.docs[index]["phoneNumber"];
                String profileImage =
                    snapshot.data!.docs[index]["profileImage"];

                return ListTile(
                  onTap: () {},
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(profileImage),
                  ),
                  title: Text(firstName + lastName),
                  subtitle: Text(email),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
