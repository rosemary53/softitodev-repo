//Tip Güvenli fonksiyon imzaları
typedef MetrikUyariKurali = bool Function(double deger);

void metrikDenetle({
  required String metrikAdi,
  required double mevcutDeger,
  required MetrikUyariKurali kural,
  required void Function(String mesaj) alertTetikleyici,
}) {
  if (kural(mevcutDeger)) {
    alertTetikleyici("Uyarı: $metrikAdi eşik değerini aştı. Mevcut : $mevcutDeger");
  } else {
    print("$metrikAdi normal sınırlar içinde ($mevcutDeger)");
  }
}

void main() {
  print("Metrik Uyarıları");

  //Değişkenin içine fonksiyon gömdük.
  final MetrikUyariKurali yuksekCpu = (deger) => deger >= 85.0; // %85 ve üstü

  final MetrikUyariKurali yuksekRam = (deger) => deger >= 90.0; // %90 ve üstü

  metrikDenetle(
      metrikAdi: "CPU",
      mevcutDeger: 92.4,
      kural: yuksekCpu,
      alertTetikleyici: (mesaj) => print("Cpu için bildirim Gönderildi. $mesaj"));
  metrikDenetle(
      metrikAdi: "RAM",
      mevcutDeger: 72.0,
      kural: yuksekRam,
      alertTetikleyici: (mesaj) => print("Ram için bildirim gönderildi. $mesaj"));
}
