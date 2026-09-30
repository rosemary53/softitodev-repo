//switch : kod satırlarımızı yürütür,break ile durdurur değişkene atama yapmaz.

enum OlaySeviyesi { info, warning, error, critical }

String alarmKanaliniBelirle(OlaySeviyesi seviye, int tekrarSayisi) {
  return switch (seviye) {
    OlaySeviyesi.info =>
      "dev-logs", //Eğer gelen OlaySeviyesi tipinde seviye bilgisi OlaySeviyesi.info'ya eşitse bu satır çalışsın ve geriye "dev-logs" dönsün
    OlaySeviyesi.warning => "dev-warning",
    OlaySeviyesi.error when tekrarSayisi >= 5 => " Sms ve Email(mükerrer hata)",
    OlaySeviyesi.error => "Email:dev@site.com",
    OlaySeviyesi.critical => "Acil Durum: Kriz odası otomatik node kapanışı",
  };
}

String httpKoduYorumla(int kod) {
  return switch (kod) {
    >= 200 && < 300 => "2xx Başarılı İstek",
    >= 300 && < 500 => "4xx İstemci Hatası (client error)",
    >= 500 && < 600 => "5xx Sunucu Hatası (internal server error)",
    _ => "Tanımsız Hata Kodu"
  };
}

void main() {
  print("Warning Kanalı                  :${alarmKanaliniBelirle(OlaySeviyesi.warning, 1)}");
  print("Tekil Error Kanalı              :${alarmKanaliniBelirle(OlaySeviyesi.error, 2)}");
  print("5 Kez Tekrarlanan Error Kanalı  :${alarmKanaliniBelirle(OlaySeviyesi.error, 5)}");
  print("Kritik  Kanalı                  :${alarmKanaliniBelirle(OlaySeviyesi.critical, 1)}");

  print("HTTP 204 :  ${httpKoduYorumla(204)}");
  print("HTTP 401 :  ${httpKoduYorumla(401)}");
  print("HTTP 505 :  ${httpKoduYorumla(505)}");
}
