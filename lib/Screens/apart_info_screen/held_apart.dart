import 'package:apart/Screens/apart_info_screen/my_buy.dart';
import 'package:apart/Screens/apart_info_screen/my_sell.dart';
import 'package:flutter/material.dart';

import '../../common/colors.dart';

class HeldApartPage extends StatefulWidget {
  const HeldApartPage({super.key});

  @override
  State<HeldApartPage> createState() => _HeldApartPageState();
}

class _HeldApartPageState extends State<HeldApartPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,  // geri tuşunu kaldırır
          backgroundColor: modernBlueColor,
          title: const Text("İlan Bilgi Ekranı" ,style: TextStyle(color: modernYellowColor),),
          bottom: const TabBar(
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(text: "Tuttuğum Apartlar",),
              Tab(text: "Tutulan Apartlarım",),

            ],
            indicatorColor:modernYellowColor, //alttaki seçili çizginin rengi
            labelColor: modernYellowColor, // seçili yazıların rengi
          ),
        ),
        body:const TabBarView(
          children: [
            MyBuyApartPage(),
            MySellApartPage()
          ],
        ),

      ),
    );
  }
}

