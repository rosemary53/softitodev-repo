/*Bir bulut kümesinde çalışan servislerin isimlerini içeren bir Set<String> tanımlayın 
  (mükerrer kayıtları elemek için). Ardından bir boolean bool isProduction = true; bayrağı tanımlayın. 
  Eğer ortam prodüksiyon ise listeye "vault-secret-manager" servisini Collection if ile ekleyen ve tüm servisleri 
  içeren bir List<String> oluşturup ekrana yazdırın. */
void main() {
  final Set<String> servisIsimleri = {"auth-api", "payment-gateway"};

  final bool isProduction = true;

  final List<String> servisListesi = [
    ...servisIsimleri,
    if (isProduction) "valut-secret-manager",
  ];

  print("Servis listesi : $servisListesi");
}
