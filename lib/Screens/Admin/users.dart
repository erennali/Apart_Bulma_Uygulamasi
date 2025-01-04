import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Services/profile_info_card_widget.dart';
import '../../common/colors.dart';

class AdminUserPage extends StatefulWidget {
  const AdminUserPage({super.key});

  @override
  State<AdminUserPage> createState() => _AdminUserPageState();
}

class _AdminUserPageState extends State<AdminUserPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<List<Map<String, dynamic>>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _fetchUsers();
  }

  /// Firestore'dan kullanıcıları getir
  Future<List<Map<String, dynamic>>> _fetchUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _firestore.collection('users').get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: modernYellowColor),
        title: const Text('Kullanıcı Yönetimi',style: TextStyle(color: modernYellowColor),),
        backgroundColor: modernBlueColor,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [modernBlueColor, modernYellowColor],
            begin: Alignment.centerLeft,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _usersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Kullanıcı bulunamadı.'));
            }

            final users = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final userData = users[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: CreativeCard(
                    ad: userData['ad'] ?? 'Bilinmiyor',
                    soyad: userData['soyad'] ?? 'Bilinmiyor',
                    email: userData['email'] ?? 'Bilinmiyor',
                    telefon: userData['telefon'] ?? 'Bilinmiyor',
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}