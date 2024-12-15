import 'package:apart/Screens/apart_list.dart';
import 'package:apart/Screens/user_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/colors.dart';

class ApartCreatePage extends StatefulWidget {
  const ApartCreatePage({super.key});

  @override
  State<ApartCreatePage> createState() => _ApartCreatePageState();
}

class _ApartCreatePageState extends State<ApartCreatePage> {

  final formAnahtari = GlobalKey<FormState>();

  //radiobutton
  String opsiyon = "";
  String opsiyon_1 = "Kiralık";
  String opsiyon_2 = "Satılık";
  bool radio_1 = false;
  bool radio_2 = false;
  String seciliOpsiyon = "";

  //DROPDOWN BUTON DEĞİŞKENLERİ .
  List<String> m2ler = ["1+0", "1+1", "2+1", "3+1",">3+1"];
  String secilenM2 = "1+0";
  String m2 = "";

  //TEXTFORMFIELD DEĞİŞKENLERİ
  String baslik = "",
      aciklama = "",
      resim = "",
      adres = "";
  int fiyat =0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _save() async {
    if (formAnahtari.currentState!.validate()) {
      try {
        User? currentUser = _auth.currentUser;
        if (currentUser != null) {
          // firestoredan kullanıcı bilgilerini çekme
          DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUser.uid).get();

          String ad = userDoc['ad'] ?? 'Ad Bilinmiyor';
          String soyad = userDoc['soyad'] ?? 'Soyad Bilinmiyor';
          String telefon = userDoc['telefon'] ?? 'Telefon Bilinmiyor';


          await _firestore.collection('aparts').add({
            'baslik': baslik,
            'aciklama': aciklama,
            'fiyat': fiyat,
            'durum':true,
            'adres': adres,
            'resim': resim,
            'm2': secilenM2,
            'kategori': seciliOpsiyon,
            'ilanSahibiAd': ad,
            'ilanSahibiSoyad': soyad,
            'ilanSahibiTelefon': telefon,
            'email': currentUser.email,
            'userId': currentUser.uid,
            'createdAt': FieldValue.serverTimestamp(),
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('İlan başarıyla kaydedildi!')),
          );

          Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserMainPage()));
        }

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('HATA: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [modernBlueColor, modernYellowColor],
            begin: Alignment.centerLeft,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Form(
              key: formAnahtari,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Apart İlanı Oluştur',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Ad
                      TextFormField(
                        maxLength: 30,
                        decoration: InputDecoration(
                          labelText: 'İlan Başlığı',
                          prefixIcon: Icon(Icons.edit),
                          labelStyle: const TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: modernYellowColor),
                          ),
                        ),
                        validator: (girilenDeger) {
                          if (girilenDeger!.isEmpty) {
                            return "İlan başlığı boş bırakılamaz";
                          }
                          return null;
                        },
                        onChanged: (value) => baslik = value,
                        style: const TextStyle(color: Colors.white70),
                      ),

                      // Soyad alanı
                      TextFormField(
                        maxLength: 100,
                        decoration: InputDecoration(
                          labelText: 'Açıklama',
                          prefixIcon: Icon(Icons.message),
                          labelStyle: const TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: modernBlueColor),
                          ),
                        ),
                        validator: (girilenDeger) {
                          if (girilenDeger!.isEmpty) {
                            return "Açıklama boş bırakılamaz";
                          }
                          return null;
                        },
                        onChanged: (value) => aciklama = value,
                        style: const TextStyle(color: Colors.white70),
                      ),

                      // E-posta alanı
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          labelText: 'Fiyat',
                          hintText: "TL",
                          hintStyle: TextStyle(color: Colors.white24),
                          prefixIcon: Icon(Icons.currency_lira),
                          labelStyle: const TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: modernYellowColor),
                          ),
                        ),
                        validator: (girilenDeger) {
                          if (girilenDeger!.isEmpty) {
                            return "Fiyat boş bırakılamaz";
                          }
                          return null;
                        },
                        onChanged: (value) => fiyat = int.tryParse(value)!,
                        style: const TextStyle(color: Colors.white70),
                      ),


                      // Telefon alanı
                      const SizedBox(height: 20),
                      TextFormField(
                        maxLength: 100,
                        decoration: InputDecoration(
                          labelText: 'Adres',
                          hintStyle: TextStyle(color: Colors.white24),
                          prefixIcon: Icon(Icons.pin_drop),
                          labelStyle: const TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: modernBlueColor),
                          ),
                        ),
                        validator: (girilenDeger) {
                          if (girilenDeger!.isEmpty) {
                            return "Adres boş bırakılamaz";
                          }
                          return null;
                        },
                        onChanged: (value) => adres = value,
                        style: const TextStyle(color: Colors.white70),
                      ),

                      // Şifre alanı
                      TextFormField(

                        decoration: InputDecoration(
                          labelText: 'Resim',
                          hintText: "URL yapıştır",
                          hintStyle: TextStyle(color: Colors.white24),
                          prefixIcon: Icon(Icons.photo),
                          labelStyle: const TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: modernYellowColor),
                          ),
                        ),
                        validator: (girilenDeger) {
                          if (girilenDeger!.isEmpty) {
                            return "Resim boş bırakılamaz";
                          }
                          return null;
                        },
                        onChanged: (value) => resim = value,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      DropdownButton(
                        style: TextStyle(color: modernBlueColor),
                        dropdownColor:modernYellowColor,
                        borderRadius: BorderRadius.circular(15),
                        underline: Container(
                          height: 2,
                          color: modernBlueColor, // Alt çizgi rengi
                        ),
                        items: m2ler.map((oAnkiM2) {
                          return DropdownMenuItem(
                              child: Text(oAnkiM2), value: oAnkiM2);
                        }).toList(),
                        onChanged: (secili) {
                          setState(() {
                            secilenM2 = secili!;
                          });
                        },
                        value: secilenM2,
                      ),
                      RadioListTile(
                        activeColor: modernYellowColor,
                        selected: radio_1,
                        value: opsiyon_1,
                        groupValue: opsiyon,
                        onChanged: (deger) {
                          setState(() {
                            seciliOpsiyon ="Kiralık";
                            radio_1 = true;
                            opsiyon = deger!;
                          });
                        },
                        title: Text("Kiralık",style: TextStyle(color: modernBlueColor),),
                      ),
                      RadioListTile(
                        activeColor: modernBlueColor,
                        selected: radio_2,
                        value: opsiyon_2,
                        groupValue: opsiyon,
                        onChanged: (deger) {
                          setState(() {
                            seciliOpsiyon="Satılık";
                            radio_2 = true;
                            opsiyon = deger!;
                          });
                        },
                        title: Text("Satılık",style: TextStyle(color: modernBlueColor),),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: modernYellowColor,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: _save,
                          child: const Text(
                            "İlan Ver",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}