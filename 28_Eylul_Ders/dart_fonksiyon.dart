//Klasik Sıralı Fonksiyonumuz
double topla(double a, double b) => a + b;

//Modern Dart / Flutter standartları: Named parameters({})

//Fonksiyonun dışarıdan alabileceği değerlere parametre diyoruz.
void seansKaydiOlustur({
  //Zorunlu değerleri burada girebiliriz
  required String
      danisan, //required bir parametreye zaten kesin bir değer verileceği için başlangıçta varsayılan değer girmek anlamsızdır ve hatalıdır.
  required String tedavi,
  required double birimFiyat,
  int seansSayisi =
      1, //required olmayan bir named parameter, çağrıda verilmeyebileceği için null olamayan bir tipteyse (double, int, String vb.) varsayılan değer veya başka bir geçerli başlangıç değeri sağlanmalıdır.
  double indirimOrani = 0.0, //default değer
  String? uzmanHekim, // Bu değişken null olabilir
}) {
  final double brutTutar = birimFiyat * seansSayisi;
  final double indirimTutari = brutTutar * (indirimOrani / 100);
  final double netTutar = brutTutar - indirimTutari;

  print("""
   
   =======================================================
   SOFTITO SEANS SÖZLEŞMESİ
   -------------------------------------------------------

   Danışan              : $danisan
   Tedavi               : $tedavi (x$seansSayisi Seans)
   Uzman Hekim          : ${uzmanHekim ?? "Nöbetçi Estetisyen"}
   Birim Fiyat          : $birimFiyat
   Brüt Tutar           : $brutTutar tl
   İndirim Tutarı       : -$indirimTutari tl (%$indirimOrani)indirim yapıldı.
   Ödenecek Tutar       : $netTutar tl
   =======================================================

""");
}

void main() {
  //Fonksiyon çağrılırken parametrelere gönderilen değerlere argüman denir.
  seansKaydiOlustur(
      danisan: "Gülfidan Koçdoğan",
      tedavi: "Medikal Cilt Yenileme",
      birimFiyat: 2700,
      indirimOrani: 25.0,
      seansSayisi: 3,
      uzmanHekim: "Dr.Nazlı Turan");
}
