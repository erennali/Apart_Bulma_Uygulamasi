import 'package:flutter/material.dart';

class FormOrnek extends StatefulWidget {
  @override
  _FormOrnekState createState() => _FormOrnekState();
}

class _FormOrnekState extends State<FormOrnek> {
//FORM ANAHTARI
  final formAnahtari = GlobalKey<FormState>();

//TEXTFORMFIELD DEĞİŞKENLERİ
  String k_Adi = "",
      email = "",
      sifre = "",
      dogru_Kadi = "",
      dogruEmail = "",
      dogruSifre = "";

//CHECKBOX DEĞİŞKENLERİ
  bool checkBox_1 = false;
  String check_1 = "";

//RADIO BUTON DEĞİŞKENLERİ
  String cinsiyet = "";
  String cinsiyet_1 = "Erkek";
  String cinsiyet_2 = "Kadın";
  bool radio_1 = false;
  bool radio_2 = false;
  String seciliCinsiyet = "";

//SWITCH DEĞİŞKENLERİ
  bool switchDurumu = false;
  String switchSecme = "";

  //DROPDOWN BUTON DEĞİŞKENLERİ .
  List<String> sehirler = ["Ankara", "İstanbul", "İzmir", "Eskişehir"];
  String secilenSehir = "Ankara";
  String sehir = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Örneği"),
      ),
      body: ListView(
        children: [
          Form(
            key: formAnahtari,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//KULLANICI ADI GİRİŞİ
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Kullanıcı Adınız Giriniz",
                      labelText: "Kullanıcı Adı",
                      prefixIcon: Icon(Icons.account_box),
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger!.isEmpty) {
                        return "Kullanıcı adı alanı boş bırakılamaz";
//giriLen değer @ işareti içermiyorsa
                      } else if (girilenDeger.length < 2) {
                        return "Girdiğiniz Kullanıcı Adı Geçersiz";
                      }
                      return null; //Kurallara uygun giriş yapıldıysa null döndür
                    },
                    onSaved: (deger) {
                      k_Adi = deger!;
                    },
                  ),
//EMAİL GİRİŞİ
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Emailinizi Giriniz",
                      labelText: "Email",
                      prefixIcon: Icon(Icons.mail),
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger!.isEmpty) {
                        return "Email alanı boş bırakılamaz";
//giriLen değer @ işareti içermiyorsa
                      } else if (!girilenDeger!.contains("@")) {
                        return "Girdiğiniz mail geçersiz";
                      }
                      return null;
                    },
                    onSaved: (deger) {
                      email = deger!;
                    },
                  ),

//ŞİFRE GİRİŞİ
                  TextFormField(
                    obscureText: true, //Şifre Girişi
                    decoration: InputDecoration(
                      hintText: "Şifrenizi Giriniz",
                      labelText: "Şifre",
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger!.isEmpty) {
                        return "Şifre Alanı Boş Bırakılamaz";
                      }
                      if (girilenDeger.trim().length < 6) {
                        return "Girilen Şifre Uzunluğu Geçersiz";
                      }
                      return null;
                    },
                    onSaved: (deger) {
                      sifre = deger!;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
//MEDENİ DURUM SEÇİMİ-CHECKBOX
                  CheckboxListTile(
                    value: checkBox_1,
                    onChanged: (secildi) {
                      setState(() {
                        checkBox_1 = secildi!;
                      });
                    },
                    title: Text("Evli/Bekar"),
                    activeColor: Colors.blue,
                    checkColor: Colors.red,
                  ),
                  SizedBox(
                    height: 10,
                  ),
//CİNSİYET SEÇİLİ-RADIO BUT0NLAR
                  RadioListTile(
                    selected: radio_1,
                    value: cinsiyet_1,
                    groupValue: cinsiyet,
                    onChanged: (deger) {
                      setState(() {
                        radio_1 = true;
                        cinsiyet = deger!;
                      });
                    },
                    title: Text("Erkek"),
                  ),
                  RadioListTile(
                    selected: radio_2,
                    value: cinsiyet_2,
                    groupValue: cinsiyet,
                    onChanged: (deger) {
                      setState(() {
                        radio_2 = true;
                        cinsiyet = deger!;
                      });
                    },
                    title: Text("Kadın"),
                  ),
//EHLİYET DURUMU-SWITCH
                  SwitchListTile(
                      title: Text("Ehliyet"),
                      value: switchDurumu,
                      onChanged: (durum) {
                        setState(() {
                          switchDurumu = durum;
                        });
                      }),
                  SizedBox(
                    height: 40,
                  ),
//ŞEHİR SEÇİMİ-DROPDOWN BUTON
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      height: 50,
                      width: 160,
                      child: DropdownButton(
                        items: sehirler.map((oAnkiSehir) {
                          return DropdownMenuItem(
                              child: Text(oAnkiSehir), value: oAnkiSehir);
                        }).toList(),
                        onChanged: (secili) {
                          setState(() {
                            secilenSehir = secili!;
                          });
                        },
                        value: secilenSehir,
                      ),
                    ),
                  ),
//BUTON
                  Center(
                    child: Container(
                      child: ElevatedButton(
                        child: Text(
                          "GÖNDER",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          if (formAnahtari.currentState!.validate()) {
                            formAnahtari.currentState!.save();
                            setState(() {
                              sehir = secilenSehir;
                              switchSecme = "a";
                              dogru_Kadi = k_Adi;
                              dogruEmail = email;
                              dogruSifre = sifre;
                            });
                            if (checkBox_1) {
                              setState(() {
                                check_1 = "Evli";
                              });
                            } else {
                              setState(() {
                                check_1 = "Bekar";
                              });
                            }
                            if (radio_1) {
                              setState(() {
                                seciliCinsiyet = "Erkek";
                                radio_1 = false;
                              });
                            }
                            if (radio_2) {
                              setState(() {
                                seciliCinsiyet = "Kadın";
                                radio_2 = false;
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 300.0,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dogru_Kadi == null
                              ? ""
                              : "Kullanıcı Adınız: $dogru_Kadi",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          dogruEmail == null
                              ? ""
                              : "Email Adresiniz: $dogruEmail",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          check_1 == "" ? "" : "Medeni Durumunuz:$check_1",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          seciliCinsiyet == ""
                              ? ""
                              : "Cinsiyetiniz: $seciliCinsiyet",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          switchSecme == "a"
                              ? switchDurumu
                              ? "Ehliyetiniz Var"
                              : "Ehliyetiniz Yok"
                              : "",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          sehir == "" ? "" : "Yaşadığınız Şehir:$secilenSehir",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*FutureBuilder<DocumentSnapshot>(
future: _firestore.collection('users').doc(user.uid).get(),
builder: (context, snapshot) {
if (snapshot.connectionState == ConnectionState.waiting) {
return const Center(child: CircularProgressIndicator());
}
// Firestore'dan kullanıcı bilgilerini alıyoruz
var userData = snapshot.data;
},
),*/