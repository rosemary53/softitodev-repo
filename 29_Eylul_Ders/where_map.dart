class SunucuMetrigi {
  //Sunucu metrigi varlığına ait özelliklerimiz
  final String hostAdi;
  final String bolge;
  final double cpuYuzdesi;
  final double ramGb;
  final int aktifBaglantiSayisi;
  final bool kritikMi;

  //Hepsi final olduğu için başına const ekliyorum
  const SunucuMetrigi(
      {required this.hostAdi,
      required this.bolge,
      required this.cpuYuzdesi,
      required this.ramGb,
      required this.aktifBaglantiSayisi,
      this.kritikMi = false});

  //Başlangıçta string oalrak aldık sonrasında toString ile daha düzgün olarak yaz dedi
  @override
  String toString() => "$hostAdi [$bolge] (CPU: %$cpuYuzdesi, Ram: $ramGb GB), Conn: $aktifBaglantiSayisi";
}

void main() {
  print("Cloud Temelleri");

  //sunucuKumesi listemiz SunucuMetrigi nesnelerinden olusuyor.
  final List<SunucuMetrigi> sunucuKumesi = [
    SunucuMetrigi(
        hostAdi: "srv-eu-01",
        bolge: "eu-west",
        cpuYuzdesi: 45.2,
        ramGb: 16.0,
        aktifBaglantiSayisi: 1200,
        kritikMi: true),
    SunucuMetrigi(
        hostAdi: "srv-us-02",
        bolge: "us-west",
        cpuYuzdesi: 22.0,
        ramGb: 4.0,
        aktifBaglantiSayisi: 450,
        kritikMi: false),
    SunucuMetrigi(
        hostAdi: "srv-us-02",
        bolge: "us-east",
        cpuYuzdesi: 94.6,
        ramGb: 64.0,
        aktifBaglantiSayisi: 8900,
        kritikMi: true),
    SunucuMetrigi(
        hostAdi: "srv-ap-01",
        bolge: "ap-south",
        cpuYuzdesi: 65.2,
        ramGb: 16.0,
        aktifBaglantiSayisi: 2000,
        kritikMi: false),
  ];

  //where() ile filtreleme : cpu kullanımı %80 den fazlaysa asiriYukluSunucular da tut.

  final asiriYukluSunucular = sunucuKumesi.where((sunucu) => sunucu.cpuYuzdesi >= 80).toList();

  print("Aşırı yüklü sunucular : ${asiriYukluSunucular.length}");
  asiriYukluSunucular.forEach((sunucu) => print("*$sunucu"));

  //map() ile dönüştürme. Sunucu adlarını ve bağlantı sayılarını alarm etiketine çevirelim.

  final List<String> alarmEtiketleri = sunucuKumesi
      .map((sunucu) => "[Alert-Monitor] ${sunucu.hostAdi.toLowerCase()} -> Aktif Trafik ${sunucu.aktifBaglantiSayisi}")
      .toList();

  print("Alarm Çıktıları (ilk 3tane)");
  alarmEtiketleri.take(3).forEach((etiket) => print(" $etiket"));

  // fold() ile toplam aktif trafik gösterimi

  final int toplamAktifTrafikSayisi = sunucuKumesi.fold(0, (toplam, sunucu) => toplam + sunucu.aktifBaglantiSayisi);

  print("Toplam bağlantı: $toplamAktifTrafikSayisi");

  // every()hepsi ve any()herhangi bir

  final bool tumSunucularCalisiyorMu = sunucuKumesi.every((sunucu) => sunucu.ramGb >= 8.0);

  final bool tehlikeliSunucuVarMi = sunucuKumesi.any((sunucu) => sunucu.cpuYuzdesi >= 90.0);

  print("Tüm susnucuların Ram'i en az 8 gb mi?: ${tumSunucularCalisiyorMu ? "Evet" : "Hayır"}");
  print("Cpu kullanımı %90'ı aşan var mı?: ${tehlikeliSunucuVarMi ? "Evet" : "Hayır"}");

  // Sunucu bölgesi eu-west olan ve kritik olan sunucuları euWestSunuculari altında topluyorum. Bu iki koşulu kontrol etmek için de where kullanıyorum. En sonunda elde edilen iterasyonu da toList() ile listeye çeviriyorum.
  final euWestSunuculari = sunucuKumesi.where((sunucu) => sunucu.bolge == "eu-west" && sunucu.kritikMi).toList();

  //Ardından euwestSunucular listem içerisinde bir işlem yapacağım. Bu işlem bu sunucuların cpuYüzdesinin toplamını bulup ortalamasını almak tek tek sunucuları ele alıp işlem yapmam için de map kullandım sonrasında her bir sunucunun cpuYuzdesini toplam değişkenine ekledim en sonunda liste uzunluğuna bölerek ortalamCpu değeri buldum.
  final euWestOrtalamaCpu =
      euWestSunuculari.map((sunucu) => sunucu.cpuYuzdesi).fold(0.0, (toplam, cpuYuzdesi) => toplam + cpuYuzdesi) /
          euWestSunuculari.length;

  print("Eu west bölgesi kritik sunucu ortalama CPU ${euWestOrtalamaCpu.toStringAsFixed(2)}");
}
