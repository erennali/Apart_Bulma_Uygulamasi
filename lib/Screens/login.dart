import 'package:apart/Screens/reset_password.dart';
import 'package:apart/Screens/user_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../common/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '', sifre = '';

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: sifre,
        );
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserMainPage()));
      }
      on FirebaseAuthException catch (e) {
        String errorMessage;

        if (e.code == 'invalid-credential') {
          errorMessage = 'HATA! Lütfen e posta ve şifrenizi kontrol edin.';
        } else {
          errorMessage = e.message ?? 'Bir hata oluştu:(';
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
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Giriş Yap',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'E-posta',
                        hintText: "ornek@gmail.com",
                        labelStyle: const TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: modernYellowColor),
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
                    const SizedBox(height: 30),
                    TextFormField(
                      obscureText: true,
                      maxLength: 20,
                      decoration: InputDecoration(
                        labelText: 'Şifre',
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
                          return "Şifre Alanı Boş Bırakılamaz";
                        }
                        if (girilenDeger
                            .trim()
                            .length < 6 || girilenDeger
                            .trim()
                            .length > 20) {
                          return "Şifre 6-20 hane olmalı!";
                        }
                        return null;
                      },
                      onChanged: (value) => sifre = value,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        _login();
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
                        'Giriş Yap',
                        style: TextStyle(fontSize: 18, color: modernBlueColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ResetPasswordPage()));
                      },
                      child: const Text(
                        'Şifremi Unuttum!',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}