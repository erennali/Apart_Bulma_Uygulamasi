import 'package:apart/common/colors.dart';
import 'package:flutter/material.dart';

class CreativeCard extends StatelessWidget {
  final String ad;
  final String soyad;
  final String email;
  final String telefon;

  // Constructor
  CreativeCard({
    required this.ad,
    required this.soyad,
    required this.email,
    required this.telefon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
              "$ad $soyad",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
             Text(
              "E-Posta : $email",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 10),
                Text(
                  "Telefon : $telefon",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

