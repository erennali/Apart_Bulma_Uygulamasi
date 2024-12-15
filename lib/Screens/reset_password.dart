import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../common/colors.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool isCaptchaVerified = false;

  Future<void> _sifreSifirla() async {
    String email = emailController.text.trim();

    if (_formKey.currentState!.validate() ) {
      try {
        await _auth.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Şifre sıfırlama bağlantısı gönderildi.")),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hata: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen geçerli bir e-posta adresi girin.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: modernYellowColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: modernBlueColor,
        title: const Text(
          'Şifre Sıfırlama',
          style: TextStyle(color: modernYellowColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [modernBlueColor, modernYellowColor],
            begin: Alignment.centerLeft,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'E-posta Adresiniz',
                    hintText: "ornek@gmail.com",
                    labelStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15), // Köşe radius
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: modernYellowColor), // Odaklanıldığında border rengi
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: modernYellowColor), // Normal border rengi
                    ),
                  ),
                  style: const TextStyle(color: Colors.white70),
                  validator: (girilenDeger) {
                    if (girilenDeger == null || girilenDeger.isEmpty) {
                      return "Email alanı boş bırakılamaz";
                    } else if (!girilenDeger.contains("@")) {
                      return "Geçerli bir e-posta adresi giriniz";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: modernYellowColor),
                onPressed: _sifreSifirla,
                child: const Text(
                  'Şifre Sıfırlama E-postası Gönder',
                  style: TextStyle(color: modernBlueColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}