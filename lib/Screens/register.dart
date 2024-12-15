import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/colors.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formAnahtari = GlobalKey<FormState>();

  String ad = "",
      soyad = "",
      email = "",
      telefon = "",
      sifre = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _register() async {
    if (formAnahtari.currentState!.validate()) {
      try {
        // firebase e kullanıcı kaydetme
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: sifre,
        );

        // firestorea kullanıcı bilgileri kaydetme
         _firestore.collection('users').doc(userCredential.user!.uid).set({
          'ad': ad,
          'soyad': soyad,
          'email': email,
          'telefon': telefon,
        });

        ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('Kayıt başarılı!')),
        );
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Bir hata oluştu';
        if (e.code == 'email-already-in-use') {
          errorMessage = 'Bu e posta kullanılıyor';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
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
            const SizedBox(height: 80),
            Form(
              key: formAnahtari,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Hesap Oluştur',
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
                          labelText: 'Ad',
                          prefixIcon: const Icon(Icons.account_box),
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
                            return "Ad boş bırakılamaz";
                          } else if (girilenDeger.length < 2) {
                            return "Girdiğiniz Ad Geçersiz";
                          }
                          return null;
                        },
                        onChanged: (value) => ad = value,
                        style: const TextStyle(color: Colors.white70),
                      ),

                      // Soyad alanı
                      TextFormField(
                        maxLength: 30,
                        decoration: InputDecoration(
                          labelText: 'Soyad',
                          prefixIcon: Icon(Icons.account_box_outlined),
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
                            return "Soyad boş bırakılamaz";
                          } else if (girilenDeger.length < 2) {
                            return "Girdiğiniz Soyad Geçersiz";
                          }
                          return null;
                        },
                        onChanged: (value) => soyad = value,
                        style: const TextStyle(color: Colors.white70),
                      ),

                      // Eposta alanı
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'E-posta',
                          hintText: "ornek@gmail.com",
                          hintStyle: TextStyle(color: Colors.white24),
                          prefixIcon: Icon(Icons.mail),
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
                            return "Email alanı boş bırakılamaz";
                          } else if (!girilenDeger.contains("@")) {
                            return "Girdiğiniz mail geçersiz";
                          }
                          return null;
                        },
                        onChanged: (value) => email = value,
                        style: const TextStyle(color: Colors.white70),
                      ),

                      // Telefon alanı
                      const SizedBox(height: 20),
                      TextFormField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          labelText: 'Telefon',
                          hintText: "Başında 0 olmadan 10 haneli giriniz!",
                          hintStyle: TextStyle(color: Colors.white24),
                          prefixIcon: Icon(Icons.phone),
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
                            return "Telefon alanı boş bırakılamaz";
                          } else if (girilenDeger.length != 10) {
                            return "Lütfen 10 hane olacak şekilde giriniz";
                          }
                          return null;
                        },
                        onChanged: (value) => telefon = value,
                        style: const TextStyle(color: Colors.white70),
                      ),

                      // Şifre alanı
                      TextFormField(
                        obscureText: true,
                        maxLength: 20,
                        decoration: InputDecoration(
                          labelText: 'Şifre',
                          prefixIcon: Icon(Icons.lock),
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
                            return "Şifre boş bırakılamaz";
                          } else if (girilenDeger.length < 6) {
                            return "Şifre en az 6 karakter olmalıdır";
                          }
                          return null;
                        },
                        onChanged: (value) => sifre = value,
                        style: const TextStyle(color: Colors.white70),
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
                          onPressed: _register,
                          child: const Text(
                            "Kayıt Ol",
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