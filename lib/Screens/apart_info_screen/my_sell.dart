import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/colors.dart';

class MySellApartPage extends StatefulWidget {
  const MySellApartPage({super.key});

  @override
  State<MySellApartPage> createState() => _MySellApartPageState();
}

class _MySellApartPageState extends State<MySellApartPage> {
  final currentUserEmail = FirebaseAuth.instance.currentUser?.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('aparts')
            .where('durum', isEqualTo: false )
            .where('email', isEqualTo: currentUserEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [modernBlueColor, modernYellowColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Center(
                child: Text(
                  "Tutulan apartınız yok.",
                  style: TextStyle(fontSize: 18,color: Colors.white70),
                ),
              ),
            );
          }

          final apartList = snapshot.data!.docs;

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [modernBlueColor, modernYellowColor],
                begin: Alignment.centerLeft,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ListView.builder(
              itemCount: apartList.length,
              itemBuilder: (context, index) {
                var apart = apartList[index].data() as Map<String, dynamic>;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient:const LinearGradient(
                        colors: [modernBlueColor, modernYellowColor],
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: apart['resim'] != null && apart['resim']!.isNotEmpty
                          ? Image.network(
                        apart['resim'],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                          : const Icon(Icons.apartment, size: 60),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            apart['baslik'] ?? "Başlık Yok",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${apart['kategori']} Fiyat: ${apart['fiyat']} TL",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {

                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
