import 'package:apart/Services/profile_info_card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../common/colors.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {


  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    if (user == null) {
      return const Center(child: Text('Kullanıcı Girişi Yapılmadı'));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app, color: modernYellowColor),
          onPressed: () {
            Navigator.pop(
                context);
          },
        ),
        iconTheme: const IconThemeData(color: modernYellowColor),
        backgroundColor: modernBlueColor,
        title:  const Text(
                "Profil",
                style: TextStyle(color: modernYellowColor),
              ),

      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [modernBlueColor, modernYellowColor],
            begin: Alignment.centerLeft,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: _firestore.collection('users').doc(user.uid).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Firestoredan kullanıcı bilgilerini alma
                var userData = snapshot.data;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CreativeCard(
                          ad: '${userData!['ad']}',
                          soyad: '${userData!['soyad']}',
                          email: '${userData!['email']}',
                          telefon: '${userData!['telefon']}'),

                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );

  }
}
