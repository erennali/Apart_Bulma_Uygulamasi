import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Services/profile_info_card_widget.dart';
import '../../common/colors.dart';

class AdminApartPage extends StatefulWidget {
  const AdminApartPage({super.key});

  @override
  State<AdminApartPage> createState() => _AdminApartPageState();
}

class _AdminApartPageState extends State<AdminApartPage> {
  String formatTimestamp(Timestamp timestamp) {
    // Timestamp'ı okunabilir bir tarih formatına çevirir
    DateTime date = timestamp.toDate();
    return DateFormat('dd MMM yyyy, HH:mm').format(date);
  }
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
    await _firestore.collection('aparts').get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: modernYellowColor),
        title: const Text('Apart Yönetimi',style: TextStyle(color: modernYellowColor),),
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
                  child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [modernYellowColor, modernBlueColor],
                          begin: Alignment.centerLeft,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'İlan Sahibi: ${userData['ilanSahibiAd'] ?? 'Bilinmiyor'} ${userData['ilanSahibiSoyad'] ?? 'Bilinmiyor'}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'İlan Başlık:${userData['baslik'] ?? 'Bilinmiyor'}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Kategori: ${userData['kategori'] ?? 'Bilinmiyor'}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'M2: ${userData['m2'] ?? 'Bilinmiyor'}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "İlan Tarih: ${userData['createdAt'] != null ? formatTimestamp(userData['createdAt']) : 'Bilinmiyor'}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                userData['email'] ?? 'Bilinmiyor',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                userData['ilanSahibiTelefon'] ?? 'Bilinmiyor',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),

                              //İlanı tutan

                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'İlanı Tutan: ${userData['tutanKullaniciAdi'] ?? 'Tutulmadı'} ${userData['tutanKullaniciSoyadi'] ?? ''}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Tutulma Tarihi: ${userData['tutulmaTarihi'] != null ? formatTimestamp(userData['createdAt']) : 'Bilinmiyor'}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                userData['tutanKullaniciEmail'] ?? 'Bilinmiyor',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                userData['tutanKullaniciTelefon'] ?? 'Bilinmiyor',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              //İlanı tutan

                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                );
              },
            );
          },
        ),
      ),
    );
  }
}