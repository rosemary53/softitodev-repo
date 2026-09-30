enum CihazTipi { sensor, gateway, edgeServer, router }

//IotCihaz Sınıfını Oluşturalım
class IotCihaz {
  //Bu sınıfa ait ilgili özelliklerim/alanlarım
  final String seriNo;
  final String cihazAdi;
  final double cpuYukYuzdesi;
  final int bellekMb;
  final bool sslSertifikasiGecerliMi;

  final CihazTipi cihazTipi;
  final Set<String> acikPortlar;

  //Kurucu metod tanımlaması
  IotCihaz(
      {required this.seriNo,
      required this.cihazAdi,
      required this.cpuYukYuzdesi,
      required this.bellekMb,
      this.sslSertifikasiGecerliMi = false,
      required this.acikPortlar,
      required this.cihazTipi});

  //getterlarımız: getterlarımıza bir değişken gibi erişebiliyoruz. Ancak tam anlamıyla değişken değiller çünkü arka planda kod bloğu çalışıtırıyorlar.
  bool get guvenlikAcigiVarMi => !sslSertifikasiGecerliMi || acikPortlar.contains("23/TELNET");

  bool get riskliMi => guvenlikAcigiVarMi || cpuYukYuzdesi > 85.0;

  bool get cihazKapaliMi => cpuYukYuzdesi == 0.0 && bellekMb == 0.0;
}

//Riskli Cihazları Bulma :
//Güvenlik açığı varsa , CPU kullanımı %85 'ten büyükse bu iki durumdan en azından birini sağlıyorsa bile riskli cihaz kabul et ve riskli cihaz listesine ekle .Bundan dolayı || kullanırız.
void riskliCihazlariBul(List<IotCihaz> cihazListesi) {
  //gelen cihazListesi boş mu değil mi kontrol et
  if (cihazListesi.isEmpty) {
    print("Cihaz listeniz boş.");
    return;
  }
  /*Cihaz listesindeki her bir cihazı ele alıyorum. Ardından where komutu ile her bir cihazı koşula tabi tutuyorum. */
  final riskliCihazListesi =
      cihazListesi.where((cihaz) => cihaz.guvenlikAcigiVarMi || cihaz.cpuYukYuzdesi > 85.0).toList();
  print("-->Riskli Cihaz Bilgilerimiz");
  for (var cihaz in riskliCihazListesi) {
    print(
        "Cihaz Adı: ${cihaz.cihazAdi} | Cihaz Tipi: ${cihaz.cihazTipi} | Açık Portlar: ${cihaz.acikPortlar.isEmpty ? "Açık port yok" : cihaz.acikPortlar}");
  }
}

//Toplam bellek kullanımını hesaplama:
//Ağdaki bütün cihazların kullandığı toplam belleği hesaplayın.
/*
   Ben parametre olarak IotCihaz nesnelerinden oluşan bir liste alıyorum.
   Ardından gelen liste boş mu değil mi onun kontrolünü yapıyorum boş ise direkt fonksiyonu sonlandırıyorum.
   Boş değilse öncelikle toplam bellek kullanimini tutacağım bir final değişken tanımlıyorum
   çalışma zamanı değer alacak.
   Ardından bana parametre ile dışarıdam gelen liste içinde tek tek dolaşmam gerekecek bundan dolayı da map() fonksiyonunu kullanıyorum. Map ile listedeki IotCihaz nesnelerinin her birini tek tek ele alıyorum . Bu nesneleri elde edince özelliklerine de ulaşabiliyorum.
   Nesne üzerinden ilgili bellekMb özelliğini alıyorum.
   Sonrasında bu bellekleri toplamam gerek bunun için fold() fonksiyonunu kullanıyorum.
   fold içerisinde 2 adet değişken tanımlıyorum toplam değişkenine 0.0 atanıyor. bellekMb ye ise cihaz.bellekMb değeri atanıyorum . her defasında da toplam değişkenine bellekMb her ensne için ekleniyor.
   */
void toplamBellekKullanimiHesapla(List<IotCihaz> cihazListesi) {
  if (cihazListesi.isEmpty) {
    print("Cihaz listeniz boş.");
    return;
  }

  final toplamBellekKullanimi =
      cihazListesi.map((cihaz) => cihaz.bellekMb).fold(0.0, (toplam, bellekMb) => toplam + bellekMb);

  print("Elde etilen toplam bellek kullanimi: $toplamBellekKullanimi");
}

//Seri Numarasına Göre Cihaz Bul : Dart 3 Record
/* 
    1.Seri numarasını zorunlu parametre olarak ayarlarım.
    2.Seri numarasina göre bulmasi ilgili IotCihazi bulmasi için listedeki her elemanı gezip seriNumaralari eşleşiyor mu diye kontrol etmesi lazım. Bundan dolayı da foreach kurdum

  */
({String cihazAdi, CihazTipi cihazTipi, bool alarmDurumu}) seriNumarasinaGoreBilgiGetir({
  required List<IotCihaz> cihazListesi,
  required String seriNumarasi,
}) {
  for (var cihaz in cihazListesi) {
    if (cihaz.seriNo == seriNumarasi) {
      return (cihazAdi: cihaz.cihazAdi, cihazTipi: cihaz.cihazTipi, alarmDurumu: cihaz.riskliMi);
    }
  }
  throw Exception("Seri numarasina sahip cihaz bulunamadi.");
}

/*
    Cihazın tipine göre bir güvenlik izolasyon bölgesi kodu döndüren bir metot yazın.
    Bu işlemde Dart 3 Switch Expression kullanılması zorunludur.
    Switch içinde bütün enum değerlerini kullandığım için _ bu değri kullanmama gerek kalmadı. Eğer 1 tanesini bile kullanmasaydım _ => ".." kullanbilirdim.
  */
String guvenlikIzolasyonKoduDondur(CihazTipi cihazTipi) {
  return switch (cihazTipi) {
    CihazTipi.edgeServer => "ZONE-E",
    CihazTipi.gateway => "ZONE-G",
    CihazTipi.router => "ZONE-R",
    CihazTipi.sensor => "ZONE-S"
  };
}

class CihazErisilemezException implements Exception {
  final String mesaj;

  CihazErisilemezException(this.mesaj);

  @override
  String toString() => mesaj;
}

String cihazErisilebilirMi(IotCihaz cihaz) {
  if (cihaz.cihazKapaliMi) {
    throw CihazErisilemezException("${cihaz.cihazAdi} adlı cihaz erişilemez durumdadır.");
  }
  return "Cihazınız erişilebilir durumdadır.";
}

void main() {
  print("=====================================================");
  print("             Iot Cihazları Bilgi Paneli");
  print("=====================================================\n");

  final List<IotCihaz> iotCihazListesi = [
    IotCihaz(
      seriNo: "SN-001",
      cihazAdi: "Edge Server 01",
      cpuYukYuzdesi: 72.5,
      bellekMb: 4096,
      acikPortlar: {"80/HTTP", "443/HTTPS"},
      cihazTipi: CihazTipi.edgeServer,
      sslSertifikasiGecerliMi: true,
    ),
    IotCihaz(
      seriNo: "SN-002",
      cihazAdi: "Gateway 01",
      cpuYukYuzdesi: 45.2,
      bellekMb: 2048,
      acikPortlar: {"80/HTTP", "23/TELNET"},
      cihazTipi: CihazTipi.gateway,
      sslSertifikasiGecerliMi: false,
    ),
    IotCihaz(
      seriNo: "SN-003",
      cihazAdi: "Router 01",
      cpuYukYuzdesi: 18.7,
      bellekMb: 1024,
      acikPortlar: {"22/SSH", "443/HTTPS"},
      cihazTipi: CihazTipi.router,
      sslSertifikasiGecerliMi: true,
    ),
    IotCihaz(
      seriNo: "SN-004",
      cihazAdi: "Sensor 01",
      cpuYukYuzdesi: 0.0,
      bellekMb: 0,
      acikPortlar: {},
      cihazTipi: CihazTipi.sensor,
      sslSertifikasiGecerliMi: false,
    ),
  ];

  riskliCihazlariBul(iotCihazListesi);

  print("\n-----------------------------------------------------");
  toplamBellekKullanimiHesapla(iotCihazListesi);

  print("\n-----------------------------------------------------");
  final cihazBilgi = seriNumarasinaGoreBilgiGetir(cihazListesi: iotCihazListesi, seriNumarasi: "SN-004");

  print("Cihaz Adı           : ${cihazBilgi.cihazAdi}");
  print("Cihaz Tipi          : ${cihazBilgi.cihazTipi.name}");
  print("Cihaz Alarm Durumu  : ${cihazBilgi.alarmDurumu ? "Cihazınız riskli" : "Cihazının riskli değil"}");
  print("\n-----------------------------------------------------");

  String guvenlikIzolasyonKodu = guvenlikIzolasyonKoduDondur(iotCihazListesi[2].cihazTipi);
  print("${iotCihazListesi[2].cihazAdi} cihazına ait güvenlik izolasyon bölgesi kodu : $guvenlikIzolasyonKodu");

  print("\n-----------------------------------------------------");

  try {
    String mesaj = cihazErisilebilirMi(iotCihazListesi[2]);
    print(mesaj);
  } on CihazErisilemezException catch (err) {
    print("Hata meydana geldi : $err");
  }
  print("\n-----------------------------------------------------\n");
}
