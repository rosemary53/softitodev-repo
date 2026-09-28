//1.Enumları (derleme zamanı güvenliği)

import 'dart_fonksiyon.dart';

enum HizmetKategorisi {
  ciltYenileme,
  medikalEstetik,
  lazerEpilasyon,
  Lipo,
}

enum SeansDurumu { bekliyor, odadaIslemde, tamamlandi, iptalEdildi }

enum OdemeYontemi { krediKarti, havaleEft, nakit, klinikPaketKredisi }

//Danışman(müşteri) Modeli
class Danisan {
  final String id;
  final String adSoyad;
  final String telefon;
  final bool vipUyeMi;
  final List<String> alerjiler; //boş olabilir ama null olamaz

  final String? ozelCiltNotu; //Opsiyonel Null olabilir

  const Danisan({
    required this.id,
    required this.adSoyad,
    required this.telefon,
    this.vipUyeMi = false,
    this.alerjiler = const [],
    this.ozelCiltNotu,
  });

  bool get hassasCiltMi =>
      alerjiler.isNotEmpty; //Eğer alerji listesi boş değilse geriye true dönecek ve hassasCilt olduğu anlaşılacak

  //Bilgi Özet Kartı
  String get bilgiOzeti {
    final String alerjiBilgisi = alerjiler.isEmpty ? "Kayıtlı Alerji Yok" : "Alerjiler: ${alerjiler.join(",")}";
    final String notBilgisi = ozelCiltNotu ?? "Özel Medikal Not Girilememiş"; //ifNull
    final String vipRozeti = vipUyeMi ? "VİP" : "Standart";
    return "$vipRozeti $adSoyad ($telefon)| $alerjiBilgisi | Not: $notBilgisi";
  }
}

//Seans Modeli

class SeansKaydi {
  final String seansKodu;
  final String islemAdi;
  final int seansSayisi;
  final String? sorumluUzman;
  final double birimFiyat;
  final double indirimOrani;

  final HizmetKategorisi kategori;
  final Danisan danisan;

  SeansDurumu durum;
  OdemeYontemi? odemeTipi;

  SeansKaydi({
    required this.seansKodu,
    required this.islemAdi,
    required this.birimFiyat,
    required this.kategori,
    required this.danisan,
    this.seansSayisi = 1,
    this.indirimOrani = 0.0,
    this.sorumluUzman,
    this.durum = SeansDurumu.bekliyor,
    this.odemeTipi,
  });

  //Getterlarımız :Bir özelliğe değişken gibi erişmemizi sağlayan, ama arka planda kod çalıştırabilen yapıdır.
  double get brutTutar => birimFiyat * seansSayisi;

  double get indirimTutar {
    double toplamOran = indirimOrani;

    if (danisan.vipUyeMi) {
      toplamOran += 10.0;
    }
    return brutTutar * (toplamOran / 100.0);
  }

  double get netTutar => brutTutar - indirimTutar;
}

//Yönetim Servisi

class KlinikYoneticisi {
  final String subeAdi;
  final List<SeansKaydi> _seanslar = [];
  final Map<String, Danisan> _danisanRehberi = {};

  KlinikYoneticisi({required this.subeAdi});

  //Danışan kaydetme
  void danisanKaydet(Danisan danisan) {
    _danisanRehberi[danisan.id] = danisan;
    print("Rehbere eklendi: ${danisan.adSoyad} ${danisan.vipUyeMi ? "VIP" : "Standart"}");
  }

  //Randevu oluştur
  void randevuOlustur(SeansKaydi seans) {
    _seanslar.add(seans);
    print("Randevu kaydedildi. [${seans.seansKodu}]: ${seans.danisan}-> ${seans.islemAdi}]");
  }

  //Seans tamamla
  void seansTamamla({
    required String seansKodu,
    required OdemeYontemi odeme,
  }) {
    for (var seans in _seanslar) {
      if (seans.seansKodu == seansKodu) {
        seans.durum = SeansDurumu.tamamlandi;
        seans.odemeTipi = odeme;
        print(
            "Seans tamamlandı. [${seans.seansKodu}]: ${seans.netTutar.toStringAsFixed(2)} tahsil edildi. ${odeme.name}");
      }
      print("Hata [$seansKodu] kodlu seans bulunamadi.");
      return;
    }
  }

  //Seans iptal etme
  void seansIptalEt(String seansKodu, {String? iptalNedeni}) {
    for (var seans in _seanslar) {
      if (seans.seansKodu == seansKodu) {
        seans.durum = SeansDurumu.iptalEdildi;
        print("Seans iptal edildi. [${seans.seansKodu}] : kodlu seans ${iptalNedeni ?? "Gerekçe belirtilmedi"}");
        return;
      }
    }
  }

  //Finansal Rapor Metodları(fonksiyonel Dart)
  double get toplamTahsilEdilenCiro => _seanslar
      .where((seans) => seans.durum == SeansDurumu.tamamlandi)
      .fold(0.0, (toplam, seans) => toplam + seans.netTutar);

  double get beklenenPotansiyelCiro => _seanslar
      .where((seans) => seans.durum == SeansDurumu.bekliyor || seans.durum == SeansDurumu.odadaIslemde)
      .fold(0.0, (toplam, seans) => toplam + seans.netTutar);

  //Kategori bazlı seans sayıları

  Map<HizmetKategorisi, int> kategoriBazliSeansDagilimi() {
    final Map<HizmetKategorisi, int> dagilim = {};

    for (var kategori in HizmetKategorisi.values) {
      dagilim[kategori] = 0;
    }
    for (var seans in _seanslar) {
      dagilim[seans.kategori] = (dagilim[seans.kategori] ?? 0) + 1;
    }
    return dagilim;
  }

  Set<String> gorevliUzmanKadrosu() {
    return _seanslar
        .map((seans) => seans.sorumluUzman)
        .whereType<String>()
        .toSet(); //farklı seansların uzmanı aynı olabilir tekrar edenler eklenmesin
  }

  //Uzmansız kalan seanslar
  List<SeansKaydi> uzmansizSeanslariGetir() {
    return _seanslar.where((seans) => seans.sorumluUzman == null).toList();
  }

  void gunSonuRaporuYazdir() {
    print("Günlük Seans ve İşlem Çizelgesi");
    print("=======================================");
    print("${'Kod'.padRight((10))}|"
        "${'Danışan'.padRight((16))}|"
        "${'İşlem'.padRight((20))}|"
        "${'Uzman'.padRight((18))}|"
        "${'Tutar'.padRight((10))}|"
        "${'Durum'}|");

    print("========================================");

    for (var seans in _seanslar) {
      final String uzman = seans.sorumluUzman ?? "Nöbetçi Bekliyor";
      final String durumRozet = switch (seans.durum) {
        SeansDurumu.tamamlandi => "Tamamlandı",
        SeansDurumu.odadaIslemde => "İşlemde",
        SeansDurumu.bekliyor => "Bekliyor",
        SeansDurumu.iptalEdildi => "İptal Edildi"
      };

      print(
        "${seans.seansKodu.padRight(10)}|"
        "${seans.danisan.adSoyad.padRight(10)}|"
        "${seans.islemAdi.padRight(10)}|"
        "${uzman.padRight(10)}|"
        "${seans.netTutar.toStringAsFixed(2).padRight(10)} |"
        "$durumRozet",
      );
    }

    print("----------------------------------------");
    print("Finansal Özet");
    print("*Gerçekleşen (kasadaki net ciro) : ${toplamTahsilEdilenCiro.toStringAsFixed(2)}");
    print("* Bekleyen Potansiyel Alacak : ${beklenenPotansiyelCiro.toStringAsFixed(2)}");

    print(" * Toplam Seans: ${_seanslar.length} randevu");
    print("===========================================");
    print("Aktif Uzmanlar");

    final uzmanlar = gorevliUzmanKadrosu();
    if (uzmanlar.isEmpty) {
      print("Kayıtlı Uzman Bulunamadi.");
    } else {
      print(" ${uzmanlar.join(',')}");
    }

    final uzmansizlar = uzmansizSeanslariGetir();
    if (uzmansizlar.isNotEmpty) {
      print("Dikkat: ${uzmansizlar.length} adet seansa henüz uzman atanmamıştır.");
      for (var uzman in uzmansizlar) {
        print("->[${uzman.seansKodu}] ${uzman.danisan.adSoyad} (${uzman.islemAdi})");
      }
    }
    print("---------------------------------------------");
  }
}

void main() {
  print("Klinik Yönetim Sistemi Başlatılıyor...");
  final yonetici = KlinikYoneticisi(subeAdi: "SoftIto Bağcılar Şubesi");

  print("Danışan bilgileri giriliyor.");
  final danisan1 = Danisan(
      id: "DAN-101",
      adSoyad: "Gülfidan Koçdoğan",
      telefon: "123",
      vipUyeMi: true,
      alerjiler: ["retinol", "aspirin"],
      ozelCiltNotu: "Cilt bariyeri hassas");
  final danisan2 = Danisan(
    id: "DAN-102",
    adSoyad: "Ayşe Yılmaz",
    telefon: "345",
    vipUyeMi: false,
    alerjiler: [],
  );
  final danisan3 = Danisan(
      id: "DAN-103",
      adSoyad: "Barış Yılmaz",
      telefon: "345",
      vipUyeMi: true,
      alerjiler: [],
      ozelCiltNotu: "Cilt bariyeri hassas");

  yonetici.danisanKaydet(danisan1);
  yonetici.danisanKaydet(danisan2);
  yonetici.danisanKaydet(danisan3);

  print("Danışan güvenlik kontrolü");
  print(danisan1.bilgiOzeti);
  print(danisan2.bilgiOzeti);
  print("-*30");

  final seans1 = SeansKaydi(
      seansKodu: "SNS-101",
      islemAdi: "Lipo sdlkksdk",
      birimFiyat: 7000.0,
      kategori: HizmetKategorisi.Lipo,
      danisan: danisan1,
      seansSayisi: 2,
      indirimOrani: 5.0,
      sorumluUzman: "Dr.Nazlı Turan");
  final seans2 = SeansKaydi(
      seansKodu: "SNS-102",
      islemAdi: "Siverex ile yüz temizleme",
      birimFiyat: 6500.0,
      kategori: HizmetKategorisi.ciltYenileme,
      danisan: danisan2,
      seansSayisi: 5,
      indirimOrani: 20.0,
      sorumluUzman: null);
  final seans3 = SeansKaydi(
      seansKodu: "SNS-103",
      islemAdi: "Tüm Vücut",
      birimFiyat: 1700.0,
      kategori: HizmetKategorisi.lazerEpilasyon,
      danisan: danisan3,
      seansSayisi: 8,
      sorumluUzman: "Dr.Kerim Turgut");

  //Randevu oluştur
  yonetici.randevuOlustur(seans1);
  yonetici.randevuOlustur(seans2);
  yonetici.randevuOlustur(seans3);

  print("Seanslar gönderiliyor.");

  //Seans 1 başarıyla tamamlanıyor (kredi kartı ile ödeme)
  yonetici.seansTamamla(seansKodu: seans1.seansKodu, odeme: OdemeYontemi.krediKarti);
  //Seans  2 başarıyla tamamlanıyor (nakit ödeme)
  yonetici.seansTamamla(seansKodu: seans2.seansKodu, odeme: OdemeYontemi.nakit);
  //Seans 3 iptal ediliyor.
  yonetici.seansIptalEt(seans3.seansKodu, iptalNedeni: "Danışanın şehir dışından geldiği için gelemedi.");

  yonetici.gunSonuRaporuYazdir();
}
