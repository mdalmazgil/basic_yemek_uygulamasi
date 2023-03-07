import 'package:flutter/material.dart';
import 'package:yemek_uygulamasi/DetaySayfa.dart';
import 'package:yemek_uygulamasi/Yemekler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  Future<List<Yemekler>> yemekleriGetir() async { // Future yapısını kullanabilmek için FutureBuild yapısını kullanmak gerekmektedir.
    var yemekListesi = <Yemekler>[];

    var y1 = Yemekler(1, "Köfte", "kofte.png", 74.99);
    var y2 = Yemekler(2, "Ayran", "ayran.png", 5.0);
    var y3 = Yemekler(3, "Fanta", "fanta.png", 10.0);
    var y4 = Yemekler(4, "Makarna", "makarna.png", 20.0);
    var y5 = Yemekler(5, "Kadayıf", "kadayif.png", 25.0);
    var y6 = Yemekler(6, "Baklava", "baklava.png", 35.0);
    
    yemekListesi.add(y1);
    yemekListesi.add(y2);
    yemekListesi.add(y3);
    yemekListesi.add(y4);
    yemekListesi.add(y5);
    yemekListesi.add(y6);

    return yemekListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Yemekler"),
      ),
      body: FutureBuilder<List<Yemekler>>(
        future: yemekleriGetir(),
        builder: (context, snapshot){ // snapshot nesnesi sayesinde metod çalıştıktan sonra veri gelip gelmediğini kontrol etmemizi sağlamaktadır.
          if(snapshot.hasData){ // metod sonucu veri geldi mi ?
             var yemekListesi = snapshot.data;

             return ListView.builder(
               itemCount: yemekListesi!.length, // listView içerisinde yer alacak item sayısı.
               // itemBuilder döngü gibi çalışmaktadır.
               itemBuilder: (context,indeks){ // context sayfayı ifade eder, indeks liste içerisindeki bilgileri almak için kullanacağımız yardımcı bir yapı
                  var yemek = yemekListesi[indeks];

                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context) => DetaySayfa(yemek: yemek)));
                    },
                    child: Card(
                      child: Row(
                        children: [
                          SizedBox(width: 150, height: 150, child: Image.asset("resimler/${yemek.yemek_resim_adi}")),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(yemek.yemek_adi, style: TextStyle(fontSize: 25),),
                              SizedBox(height: 50,), // SizedBox ile istediğimiz kadar boşluk verebilmekteyiz.
                              Text("${yemek.yemek_fiyat} \u{20BA}", style: TextStyle(fontSize: 20, color: Colors.blue),),
                            ],
                          ),
                          Spacer(),  // Spacer ile boşluk bırakacağım, boşluğun ne kadar olacağı ekrandan ekrana değişmektedir.
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  );
               },
             );
          }
          else { // metod sonucu veri gelmiyorsa boş bir sayfa göster.
            return Center();
          }
        },
      ),
    );
  }
}