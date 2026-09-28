//1.Enumları (derleme zamanı güvenliği)
/*
  Enum Nedir?
  -Sabittirler
  -Çalışma zamanında değerlendirilirler.
  -Kodu okumayı kolaylaştırır.
  - Aynı tipteki sabit değerleri bir araya getirerek gruplandırır.
  -Sayısal olmayan değerlerden oluşan bir kümeyi temsil etmek için kullanılabilir.
*/
enum HizmetKategorisi {
  //HizmetKategorisi enum'ı sabit sayıda sabit değeri temsil etmek için kullanılam özel sınıf türüdür. Kod okunabilirliğini artırır. Hata değerlerini azaltır.
  ciltYenileme,
  medikalEstetik,
  lazerEpilasyon,
  Lipo,
}

enum SeansDurumu {
  //Seans durumunun da alacağı değerler aşağıda sabit bir şekilde verilmiştir.
  bekliyor,
  odadaIslemde,
  tamamlandi,
  iptalEdildi
}

enum OdemeYontemi {
  //OdemeYonteminin alacağı değerler bunlardır ve sabittirler.
  krediKarti,
  havaleEft,
  nakit,
  klinikPaketKredisi
}

//Danışman(müşteri) Modeli
class Danisan {
  //Müşteriye ait bir sınıftır.

  //Danisan sınıfına ait alanlar/özellikler
  final String id; //Müşteriyi diğer müşterilerden benzersiz kılan özellik/alan
  final String adSoyad; //Müşterinin ad,soyad bilgisi
  final String telefon; //Müşterinin telefon bilgisi
  final bool vipUyeMi; //Müşterinin vip üyeliği var mı onun bilgisi
  final List<String> alerjiler; //Müşterinin birden fazla alerjisi olabilir bundan dolayı liste tanımladık.

  final String? ozelCiltNotu; //Müşterinin özel cilt notu alanı. Bu alan boş bırakılabilir veya değer verilebilir.

  //Danisan sınıfına ait kurucu metodlar
  //Bu sınıftan derleme zamanında sabit nesneler üretilebiliyor. Tüm alanlarımız final bundan dolayı const ekleyebiliriz.
  const Danisan({
    required this.id, //Bu id alanına değer verilmesi zorunlu
    required this.adSoyad, //Müşterinin ad,soyad bilgisi zorunlı
    required this.telefon, //Müşterinin telefon bilgisi zorunlu
    this.vipUyeMi =
        false, //Müşterinin vip üye bilgisi varsayılan olarak başlangıç için false ayarlandı. Kullanıcı değer vermezse varsayılan değer kullanılır.
    this.alerjiler =
        const [], //Müşteriye ait alerji listesi başlangıçta boş liste olarak ayarlandı.Dart,varsayılan değerlerinin derleme zamanında bilinen sabitler olmasını ister.
    this.ozelCiltNotu, //Müşteri tarafından not değeri girilebilir de girilmeyebilir de bundan dolayı varsayılan atamadık. Null olabilen alanlarda required yazmamıza gerek yoktur.
  });

  /* Getter Nedir?
    Dışarıdan değişken gibi okunan ama arkada küçük bir fonksiyon gibi çalışan özel bir üyedir. Değer saklamaz, her okunduğunda hesaplanır.
   */
  bool get hassasCiltMi => alerjiler
      .isNotEmpty; // Burada geriye dönen getter türümüz bool. hassasCiltMi getterın adıdır. => Geriye değer döndüren kısımdır. Burada yapılan işlem şudur eğer alerjiler listesi boş değilse hassasCiltMi getterı true değer alsın.

  //Bilgi Özet Kartı Getterı
  String get bilgiOzeti {
    final String alerjiBilgisi = alerjiler.isEmpty
        ? "Kayıtlı Alerji Yok"
        : "Alerjiler: ${alerjiler.join(",")}"; // Eğer müşteriye ait alerji listesi boşsa geriye "Kayıtlı Alerji Yok" döner. Eğer alerji listesi boş değilse geriye string döner.
    final String notBilgisi = ozelCiltNotu ??
        "Özel Medikal Not Girilememiş"; //ozelCiltNotu null değer alabileceğinden burada ifNull kontrolü yapıldı.

    final String vipRozeti =
        vipUyeMi ? "VİP" : "Standart"; //vipUyeMi true ise VİP döner değilse Standart değeri geriye döner
    return "$vipRozeti $adSoyad ($telefon)| $alerjiBilgisi | Not: $notBilgisi"; //Bu bilgiOzeti getterımızı çağırdığımızda geriye String tipinde bu metin döner.
  }
}

//Seans Modeli

class SeansKaydi {
  final String seansKodu; //Her bir seansı birbirinden ayıracak olan alan
  final String islemAdi; //Seansın adı
  final int seansSayisi; //Kaç seans olacağına dair alan
  final String? sorumluUzman; //İlgili seanstan sorumlu Uzman.  Seansa uzman atanmamış olabilir.
  final double birimFiyat; //Her bir seansın birim fiyatı alanı
  final double indirimOrani; //Seansa uygulanacak olan indirimOrani Alani

  final HizmetKategorisi
      kategori; //Seansın ilişkili olduğu HizmetKategori sınıfı alanı .Yani mesela veritabanı tabloları ilişkisini düşünürsek Seans bir tablo HizmetKategori bir tabla aralarında foreign key ile ilişki kurabiliyor.

  final Danisan danisan; //İlgili seansı alan müşteri bilgisi.

  SeansDurumu durum; //seansı
  OdemeYontemi? odemeTipi; // seansın ücretini ödeme yöntemleri enumı

  SeansKaydi({
    //Seans sınıfına ait kurucu metod
    required this.seansKodu, //Bu alana değer vermek zorunlu
    required this.islemAdi, //Bu alana değer vermek zorunlu
    required this.birimFiyat, //Bu alana değer vermek zorunlu
    required this.kategori, //Bu alana değer vermek zorunlu çünkü bu alanlar sayesinde var olan Sınıfımız daha anlamlı hale gelir.
    required this.danisan, //Seans danisman olmadan var olamaycağı için bu alanda zorunlu
    this.seansSayisi = 1, // varsayılan olarak 1 atandı eğer dinamik olarak değer girilmezse 1 değeri kabul görür.
    this.indirimOrani = 0.0, //varsayılan olarak indirimOrani 0.0 ayarlandi.
    this.sorumluUzman, // sorumluUzman null olabilir şekilde belirtilmişti. Bundan dolayı burada varsayılan olarak değer ataması yapılamadı.
    this.durum = SeansDurumu.bekliyor, //seans başlangıçta bekliyor durumunda başaltıldı.
    this.odemeTipi, //Ödeme tipi null olabilir şeklinde belirtildiği için burada değer ataması yapmadım.
  });

  //Getterlarımız :Bir özelliğe değişken gibi erişmemizi sağlayan, ama arka planda kod çalıştırabilen yapıdır.Parametresizdir. Başka değerlerden türetilebilir.

  //brutTutar getterı
  double get brutTutar =>
      birimFiyat *
      seansSayisi; // Kullanıcının aldığı seans sayısına bağlı olarak brut tuatar hesaplanır. 3 adet 1000 tl den aldı desek 3000 tl ödemesi gerek.

  //indirimTutar getterı
  double get indirimTutar {
    double toplamOran = indirimOrani;

    if (danisan.vipUyeMi) {
      //Eğer müşterinin vip üyeliği varsa ekstra indirim uygulanacak
      toplamOran += 10.0; //var olan indirim oranına ekstra indirim oranı ekledik
    }
    return brutTutar * (toplamOran / 100.0); // 3000*(25/100) : 750 tl indirim
  }

  //netTutar getterı
  double get netTutar =>
      brutTutar -
      indirimTutar; // 3000-750=2250 tl ödemesi gerekli. Görüldüğü gibi arka planda işlem yapılıyor hem de değişken gibi erişilebiliyor örnek: seans.netTutar
}

//Yönetim Servisi

class KlinikYoneticisi {
  final String subeAdi; //Kliniğin şube adi tek bir bilgi tutuyoruz.
  final List<SeansKaydi> _seanslar =
      []; //Bir kliniğe ait birden fazla seans olabileceği için Liste olarak tanımladık. Bu liste içerisinde SeansKaydi sınıfına ait nesneler olacağı için tipini de SeansKaydi olarak belirledik.
  final Map<String, Danisan> _danisanRehberi =
      {}; // key: danisanınIdsi, value: Danışan nesnesinin kendisi: 'DNS-101': Danisan()

  KlinikYoneticisi({required this.subeAdi}); // zorunlu olarak verilmesi gerekn alanı subeAdi olarak tanımladık.

  //Danışan kaydetme
  /*danisanKaydet fonksiyonu danisan paramerresi argüman olarak Danisan sinifi tipinde bir nesne referamsı alır. Çünkü danisan nesnesi sayesinde danışana ait tüm bilgileri elde ederiz. */
  void danisanKaydet(Danisan danisan) {
    _danisanRehberi[danisan.id] =
        danisan; //_danisanRehberi[key(string)]=Danisan nesnesi(deger). _danisanRehberi['DNS-101'] =danisan. buradaki danisan.id parametre dışarıdan aldığı değerden gelir.
    print("Rehbere eklendi: ${danisan.adSoyad} ${danisan.vipUyeMi ? "VIP" : "Standart"}");
  }

  //Randevu oluştur
  void randevuOlustur(SeansKaydi seans) {
    //Parametre olarak SeansKaydi sınıfı tipinde bir seans değişkeni tanımlanmış.
    _seanslar.add(
        seans); //Dışarıdan gelen seans nesnesi _seanslar listesine eklenir.Seanslar aslında birer randevudur.SeansKaydi(SEA-1, Ayşe, Lazer)
    print("Randevu kaydedildi. [${seans.seansKodu}]: ${seans.danisan}-> ${seans.islemAdi}]");
  }

  //Seans tamamla

  void seansTamamla({
    required String seansKodu, //İşlemi biten seansın durumunu değiştirmek için zorunlu olarak almamız gerekir.
    required OdemeYontemi
        odeme, //İşlemi tamamlanan seansın ücret ödemesi kesinleştiği için bu bilgiyi de almamız gerekir.
  }) {
    for (var seans in _seanslar) {
      if (seans.seansKodu == seansKodu) {
        //İlgili seansın durumunu değiştirmek istiyorsak öncelikle var olan seanslar içerisinde id eşleştirmesi yaparak durumu değiştirilecek seansı buluruz.
        seans.durum = SeansDurumu.tamamlandi; //seansın durumunu enumdaki değerler yardımıyla değiştiririz.
        seans.odemeTipi = odeme;
        print(
            "Seans tamamlandı. [${seans.seansKodu}]: ${seans.netTutar.toStringAsFixed(2)} tahsil edildi. ${odeme.name}"); //işlem başarıyla gerçekleştiğinde ekrana yazar.
        return;
      } else {
        print(
            "Hata [$seansKodu] kodlu seans bulunamadi."); //ilgili seans bulunamadığında ekrana geri bildirimde bulunması gerekir.
      }
    }
  }

  //Seans iptal etme : iptal etmek istediği seansa ait seanskodunu zorunlu parametre olarak almalıdır.Çünkü seansları birbirinden ayıran temel alan burasıdır. İptal Nedeni nin belirtilmesi de kullanıcı isteğine bırakılmıştır.

  void seansIptalEt(String seansKodu, {String? iptalNedeni}) {
    for (var seans in _seanslar) {
      //Var olan tüm seanslar teker teker kontrol edilir.
      if (seans.seansKodu == seansKodu) {
        // Ele alınan her seansın koduyla silmek istediğimiz seansın kodu eşleşiyor mu ona bakılır. Eşleşme durumunda ilgili seans elde edilir ve iptal işlemleri yapılır.
        seans.durum = SeansDurumu.iptalEdildi; // seansın durumu iptal edildi olarak güncellenir.
        print(
            "Seans iptal edildi. [${seans.seansKodu}] : kodlu seans ${iptalNedeni ?? "Gerekçe belirtilmedi"}"); //Log yazılır.
        return; // seans bulunduğu için diğer seanslara bakılmaya gerek kalmaz ve fonksiyon sonlanır.
      }
    }
  }

  //Finansal Rapor Metodları(fonksiyonel Dart)
  /*
   _seanslar listesinden her bir seans teker teker ele alınır. Mevcut seansın durumu tamamlandıya eşitse parası alınmıştır. Bu eşitliği kontrol etmek için where komutu kullanılır.Ardından işlem tamamlanan seanslardan elde edilen ciroyu bulmak içinde fold metodu kullanılır.
   */
  double get toplamTahsilEdilenCiro => _seanslar
      .where((seans) => seans.durum == SeansDurumu.tamamlandi)
      .fold(0.0, (toplam, seans) => toplam + seans.netTutar);

  /* _seanslar listesinden durumu bekliyor ce odadaIslemde olan seanslar para kazandırma potansiyeline sahip seanslardır bundan dolayı koşullardan bu değerlere sahip olmaları beklenir. Ardından bunu sağlayan seansların netTıtarı potansiyelCiroya eklenir. */
  double get beklenenPotansiyelCiro => _seanslar
      .where((seans) => seans.durum == SeansDurumu.bekliyor || seans.durum == SeansDurumu.odadaIslemde)
      .fold(0.0, (toplam, seans) => toplam + seans.netTutar);

  //Kategori bazlı seans sayıları: Her i-bir kategoriye ait seans sayısı

  Map<HizmetKategorisi, int> kategoriBazliSeansDagilimi() {
    final Map<HizmetKategorisi, int> dagilim = {};

    for (var kategori in HizmetKategorisi.values) {
      dagilim[kategori] = 0; //Başlangıçta var olan tüm kategorilerin seans sayıları sıfırlanır.
    }
    //Kafamı karıştıran yerler : program (çalışırken): İlk döngü 4 kategoriyi de 0 yaptı. seans.kategori bunlardan biri. Yani dagilim[seans.kategori] her zaman bir sayı döner. Null gelmez.

    //Derleyici (kodu yazarken): Derleyici kodu çalıştırmaz, sadece türlere bakar. Ve Dart'ta bir Map'ten okuma her zaman int? türündedir bundan dolayı ifNull ?? kontrolü yapılmalıdır.derleyiciye null gelmeyeceğini garanti etmek amacıyla ?? 0 kullanılmıştır.

    for (var seans in _seanslar) {
      dagilim[seans.kategori] = (dagilim[seans.kategori] ?? 0) + 1;
      //dagilim[lazer] = (dagilim[lazer] ?? 0)+1;
      //dagilim[lazer] = 1 lazer kategorisine ait seans sayısı 1 oldu
      //bir başka seansın kategorisi de lazer oldu
      //dagilim[lazer] =(dagilim[lazer](artık 1 değerinde) ?? 0)+1;
      //dagilim[lazer] = 1+1= 2 oldu bu şekilde
    }
    return dagilim; //geriye Map döndürür.
  }

  Set<String> gorevliUzmanKadrosu() {
    return _seanslar
        .map((seans) => seans.sorumluUzman)
        .whereType<String>()
        .toSet(); //Her seansın sorumlu uzmanı map ile alınır. whereType<String>() ile atanmamış (null) uzmanlar elenir ve tür String olur. toSet() ile tekrar eden isimler kaldırılır, böylece her uzman kadroda bir kez yer alır. Geriye de bu kümemiz döndürülür.
  }

  //Uzmansız kalan seanslar
  List<SeansKaydi> uzmansizSeanslariGetir() {
    return _seanslar.where((seans) => seans.sorumluUzman == null).toList();
    //Sorumlu uzmanı henüz atanmamış (null) seansları bulup liste olarak döndürür.
    //where, _seanslar listesindeki her seans için "sorumluUzman null mı?" koşulunu kontrol eder;
    // koşulu sağlayan seanslar süzülerek kalır, sağlamayanlar elenir.
    // where sonucu Iterable türünde olduğu için toList() ile List<SeansKaydi> türüne çevrilir.
    //Döndürülen liste yenidir ama içindeki seans nesneleri _seanslar'dakilerle aynıdır (referans).
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
      //Şimdi sistemdeki var olan seanslara ait bilgileri ele alacağız bunun için döngü kurduk.
      final String uzman = seans.sorumluUzman ??
          "Nöbetçi Bekliyor"; //Seansa uzman atanmamış olabilir bundan dolayı ifNull kontrolü yapıyoruz ona göre değer dödnürüyoruz.
      final String durumRozet = switch (seans.durum) {
        //seansın durumu 4 farklı değer alabilir. Bu durum da kullancıya gösterilecğei için anlaşılır formatta olmalı Eğer durumlar aşağıdaki değerden birine eşitse geriye => sonraki değer dönecek
        SeansDurumu.tamamlandi => "Tamamlandı",
        SeansDurumu.odadaIslemde => "İşlemde",
        SeansDurumu.bekliyor => "Bekliyor",
        SeansDurumu.iptalEdildi => "İptal Edildi"
      };

      print(
        //yan yana yazılır. PadRight ile sağ tarafa 10 karakter boşluk ekler.
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
    print(
        "*Gerçekleşen (kasadaki net ciro) : ${toplamTahsilEdilenCiro.toStringAsFixed(2)}"); //double da , den sonraki gelen rakam uzun olacağı için sadece 2 sini dikkate alıyoruz.
    print("* Bekleyen Potansiyel Alacak : ${beklenenPotansiyelCiro.toStringAsFixed(2)}");

    print(
        " * Toplam Seans: ${_seanslar.length} randevu"); //Sistemde var olan toplam seans sayısını bilgi olarak veriyoruz.
    print("===========================================");
    print("Aktif Uzmanlar");

    final uzmanlar = gorevliUzmanKadrosu();
    if (uzmanlar.isEmpty) {
      //seanslarda görevli uzman sayısı 0 ise bu kod bloğu çalışır.
      print("Kayıtlı Uzman Bulunamadi.");
    } else {
      print(" ${uzmanlar.join(',')}"); // eğer görevli uzman varsa listedeki elemanalr birleştirillir.
    }

    final uzmansizlar = uzmansizSeanslariGetir();
    if (uzmansizlar.isNotEmpty) {
      //uzmanı olmayan seans listesi boş değilse bu kod bloğu çalışır.
      print(
          "Dikkat: ${uzmansizlar.length} adet seansa henüz uzman atanmamıştır."); //Kaç tane seansa uzman atanmadığı bilgisi verilmitşir.
      for (var uzman in uzmansizlar) {
        print("->[${uzman.seansKodu}] ${uzman.danisan.adSoyad} (${uzman.islemAdi})");
      }
    }
    print("---------------------------------------------");
  }
}

void main() {
  print("Klinik Yönetim Sistemi Başlatılıyor...");
  //KlinikYonetici sınıfına ait nesne oluşturuluyor
  final yonetici = KlinikYoneticisi(subeAdi: "SoftIto Bağcılar Şubesi");

  print("Danışan bilgileri giriliyor.");
  //Yeni bir danisan nesnesi oluşturma
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
