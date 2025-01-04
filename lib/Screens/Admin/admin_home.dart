import 'package:apart/Screens/Admin/adminaparts.dart';
import 'package:apart/Screens/Admin/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Services/profile_info_card_widget.dart';
import '../../common/colors.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [modernBlueColor, modernYellowColor],
              begin: Alignment.centerLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    FutureBuilder<DocumentSnapshot>(
                      future: _firestore.collection('users').doc(user?.uid).get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        // Firestoredan kullanıcı bilgilerini alma
                        var userData = snapshot.data;

                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 80),
                              Text(
                                'Yönetici Profili',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
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
                const SizedBox(height: 100),

                const SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AdminUserPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: modernYellowColor,
                      ),
                      child: const Text(
                        'Kullanıcılar',
                        style: TextStyle(fontSize: 18, color: modernBlueColor),
                      ),
                    ),

                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AdminApartPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: modernYellowColor,
                      ),
                      child: const Text(
                        'İlanlar',
                        style: TextStyle(fontSize: 18, color: modernBlueColor),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),


              ],
            ),
          )
      ),
    );
  }
}
