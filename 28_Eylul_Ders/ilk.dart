void main() {
  /*//JavaScriptteki gibi let x ="mehmet"; x=42; yaparsak hata alırız
  //print("Bu ilk dart dersidir. Dart SDK aktif olmalıdır.");

  //1.Açık belirtilen veri tipleri : Her bir değerinin veri tipini belirtmemiz gerekir.

  int seansSuresiDakika = 45;
  double seansUcretiTl = 2750.50;
  String uzmanAdi = "Dr.Gülfidan Koçdoğan";
  bool aktifMi = true;

  //2.String interpolation
  //Js'deki `${}` bunun yerine sadece $değişken girilir işlem varsa da ${değişken*2} gibi süslü parantez içerisine alınır.
  print("Uzman Adı: $uzmanAdi | Süre : $seansSuresiDakika dk | Ücret: $seansUcretiTl tl");
  print("KDV dahil: ${seansUcretiTl + seansUcretiTl * 0.2}");

  //3.var ile tip çıkarımı
  var tedaviAdi = "Kahve ile Peeling";
  //tedaviAdi = 99;// Eğer var tipinde bir değişkene değer atarsan sonrasında aynı değişkene farklı tipte bir değer atarsan hata verir.
  print(tedaviAdi);

  //4.dynamic veri tipini bağımsız kullanabilirsiniz ancak flutterda önerilmez.
  dynamic serbestKutu = "Lazer Epilasyon";
  //serbestKutu = 99; //Farklı tipte değer almasına izin verilir ancak veri tip güvenliğini yok eder.*/

  //const:Derleme anında değeri belli olan veriler, bellekte tek bir yerde saklanırlar.

  const String KLINIK_ADI = "SoftIto Güzellik Merkezi";
  const double KDV_ORANI = 0.20;

  //const DateTime suankiZaman = DateTime().now(); // Derleme anında bunu bilemeyiz.

  //final : Çalışma anında (run time) değeri hesaplanır. Bir kere değer ataması yapıldıktan sonra değeri değişmez.

  final DateTime randevuZamani = DateTime.now();
  final String takipKodu = "SOFT" + randevuZamani.microsecondsSinceEpoch.toString();

  print("Klinik adı: $KLINIK_ADI");
  print("Randevu zamani : ${randevuZamani.day}/${randevuZamani.month}/${randevuZamani.year} ve Takip Kodu: $takipKodu");

  //Null pointer exception

  //Dartta bir değişken varsayılan olarak asla NULL olamaz. Bunun yerine null safety operatörü kullanırız.(?, ??,!)
  String zorunluDanisanAdi = "Meltem Demir";
  String? danisanAlerjiNotu; // Bir değişkeni null yapmak için ? operatörü kullanılır.
  print("Alerji notu: $danisanAlerjiNotu");

  //ifNull operatörü-null ise varsayılan değer atama
  String goruntulenecekNot = danisanAlerjiNotu ?? "Bilinen bir alerjisi yok";
  print("Rapor: $goruntulenecekNot");

  //null aware : Null olan bir değeri işlem yaparken ? kullanılmalıdır.
  print("Alerji metin uzunluğu: ${danisanAlerjiNotu?.length}");
}
