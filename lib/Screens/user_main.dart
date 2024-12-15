import 'package:apart/Screens/apart_create.dart';
import 'package:apart/Screens/apart_list.dart';
import 'package:apart/Screens/apart_info_screen/held_apart.dart';
import 'package:apart/Screens/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../common/colors.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage({super.key});


  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  var sayfaListesi =[const ApartListPage(),const ApartCreatePage() ,const HeldApartPage() ,const UserProfilePage()];
  int secilenIndeks =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: sayfaListesi[secilenIndeks],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: modernBlueColor,
        color: modernYellowColor,
        buttonBackgroundColor: modernYellowColor,
        height: 60,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: modernBlueColor),
          Icon(Icons.add_circle_outline, size: 30, color: modernBlueColor),
          Icon(Icons.add_shopping_cart_sharp, size: 30, color: modernBlueColor),
          Icon(Icons.person, size: 30, color: modernBlueColor),
        ],
        onTap: (index) {
          setState(() {
            secilenIndeks = index;
          });
        },
      ),
    );
  }
}