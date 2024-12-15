import 'package:flutter/material.dart';

import '../common/colors.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Yönetici Giriş',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // E-posta alanı
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'E-posta',
                      labelStyle: const TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: modernYellowColor),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 30),
                  // Şifre alanı
                  TextField(
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
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 30),
                  // Giriş yap butonu
                  ElevatedButton(
                    onPressed: () {
                      // Giriş işlemleri
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
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
                  // Giriş yap butonu
                  TextButton(
                    onPressed: () {
                      // şifremi unuttum
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
    );
  }
}
