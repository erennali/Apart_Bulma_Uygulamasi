import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../common/colors.dart';

class ApartListPage extends StatefulWidget {
  const ApartListPage({super.key});

  @override
  State<ApartListPage> createState() => _ApartListPageState();
}

class _ApartListPageState extends State<ApartListPage> {
  int aramaMin = 0;
  int aramaMax = 9999999999;
  int aramaTutar = 0;
  bool aramaYapiliyorMu = false;

  String formatTimestamp(Timestamp timestamp) {
    // Timestamp'ı okunabilir bir tarih formatına çevirir
    DateTime date = timestamp.toDate();
    return DateFormat('dd MMM yyyy, HH:mm').format(date);
  }

  void fabFiltreleme() {
    TextEditingController minController = TextEditingController();
    TextEditingController maxController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: modernYellowColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: minController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Min Fiyat',
                  hintText: 'En düşük fiyatı girin',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: maxController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Max Fiyat',
                  hintText: 'En yüksek fiyatı girin',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        aramaMin = int.tryParse(minController.text) ?? 0;
                        aramaMax =
                            int.tryParse(maxController.text) ?? 999999999;
                      });
                      Navigator.pop(context); // bottomsheeti kapatmak için
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: modernBlueColor,
                    ),
                    child: const Text(
                      'Filtrele',
                      style: TextStyle(color: modernYellowColor),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        aramaMin = 0;
                        aramaMax = 999999999;
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: modernBlueColor,
                    ),
                    child: const Text(
                      'Sıfırla',
                      style: TextStyle(color: modernYellowColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app, color: modernYellowColor),

          onPressed: () {
            Navigator.pop(
                context);
          },
        ),
        iconTheme: const IconThemeData(color: modernYellowColor),
        backgroundColor: modernBlueColor,
        title: aramaYapiliyorMu
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: modernYellowColor),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: "Tam Fiyat Araması İçin Fiyatı Giriniz"),
                      onChanged: (value) {
                        setState(() {
                          aramaTutar = int.tryParse(value)!;
                        });
                      },
                    ),
                  ),
                ],
              )
            : const Text("Apart İlanları",
                style: TextStyle(color: modernYellowColor)),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  icon: const Icon(Icons.cancel),
                  color: modernYellowColor,
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = false;
                      aramaTutar = 0;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search),
                  color: modernYellowColor,
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: aramaYapiliyorMu
            ? FirebaseFirestore.instance
                .collection('aparts')
                .where('durum', isEqualTo: true)
                .where('fiyat', isEqualTo: aramaTutar)
                .snapshots()
            : FirebaseFirestore.instance
                .collection('aparts')
                .where('durum', isEqualTo: true)
                .where('fiyat', isGreaterThanOrEqualTo: aramaMin)
                .where('fiyat', isLessThanOrEqualTo: aramaMax)
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
                  "Apart yok.",
                  style: TextStyle(fontSize: 18, color: Colors.white70),
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
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [modernBlueColor, modernYellowColor],
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading:
                          apart['resim'] != null && apart['resim']!.isNotEmpty
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

                        showModalBottomSheet(
                          backgroundColor: modernYellowColor,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                        alignment: Alignment.center,
                                        child: Image.network(
                                          apart['resim'],
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        )),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        apart['baslik'] ?? "Başlık Yok",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Açıklama: ${apart['aciklama'] ?? 'Açıklama Yok'}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Adres: ${apart['adres']}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Metrekare: ${apart['m2']}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "İlan Tarihi: ${apart['createdAt'] != null ? formatTimestamp(apart['createdAt']) : 'Bilinmiyor'}",
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black87),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "İlan Sahibi: ${apart['ilanSahibiAd']} ${apart['ilanSahibiSoyad']}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "Telefon: ${apart['ilanSahibiTelefon']}",
                                      style: const TextStyle(
                                          color: classicTextColor, fontSize: 18,fontWeight: FontWeight.bold),
                                    ),
                                    //const SizedBox(height: 200),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          final apartId = snapshot
                                              .data!
                                              .docs[index]
                                              .id; // apart belgesinin idsi
                                          final FirebaseAuth auth =
                                              FirebaseAuth.instance;
                                          final FirebaseFirestore firestore =
                                              FirebaseFirestore.instance;
                                          User? currentUser = auth.currentUser;
                                
                                          if (currentUser != null) {
                                            try {
                                              DocumentSnapshot userDoc =
                                                  await firestore
                                                      .collection('users')
                                                      .doc(currentUser.uid)
                                                      .get();
                                
                                              String tutanAd = userDoc['ad'] ??
                                                  'Ad Bilinmiyor';
                                              String tutanSoyad =
                                                  userDoc['soyad'] ??
                                                      'Soyad Bilinmiyor';
                                              String tutanTelefon =
                                                  userDoc['telefon'] ??
                                                      'Telefon Bilinmiyor';
                                              String tutanEmail =
                                                  userDoc['email'] ??
                                                      'Email Bilinmiyor';
                                
                                              await FirebaseFirestore.instance
                                                  .collection('aparts')
                                                  .doc(apartId)
                                                  .update({
                                                'durum': false,
                                                // durum false ı apart tutulduğunda yapıyorum
                                                'tutanKullaniciSoyadi':
                                                    tutanSoyad,
                                                'tutanKullaniciAdi': tutanAd,
                                                'tutanKullaniciTelefon':
                                                    tutanTelefon,
                                                'tutanKullaniciEmail': tutanEmail,
                                                'tutulmaTarihi':
                                                    FieldValue.serverTimestamp(),
                                                // Tutulma tarihi
                                              });
                                
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        "Apart başarıyla tutuldu.")),
                                              );
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text("Hata: $e")),
                                              );
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "Kullanıcı bilgisi alınamadı.")),
                                            );
                                          }
                                        },
                                        icon: const Icon(Icons.save_alt),
                                        label: Text(
                                          "Apartı Tut : \t ${apart['fiyat']} TL",
                                          style:
                                              const TextStyle(color: modernYellowColor),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: modernBlueColor,
                                          foregroundColor: modernYellowColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 12),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fabFiltreleme,
        backgroundColor: modernBlueColor,
        child: const Icon(Icons.filter_alt, color: modernYellowColor),
      ),
    );
  }
}
