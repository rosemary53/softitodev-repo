//dart record ve api durum kontrolü

//Posional record : en güvenli record kaydı
({bool baglantiBasariliMi, double latencyMs, String nodeAdi, int statusCode}) sunucuPingAt({
  required String hedefIP,
}) {
  final double gecikmeSuresi = 24.8;
  final int kod = 200; //varsayılan Durum Kodumuz

  return (
    nodeAdi: "edge-router-ist-$hedefIP",
    statusCode: kod,
    latencyMs: gecikmeSuresi,
    baglantiBasariliMi: kod ==
        505 // Eğer kod 505'e eşitse true döner değilse false. Burada bir atama işlemi gerçekleşmiyor eşitlik kontrolü gerçekleşiyor.
  );
}

void main() {
  print("Dart Record Kayıtları");

  final probeSonucu = sunucuPingAt(hedefIP: "10.01.50");
  print("Node(İp) Adı  :                 ${probeSonucu.nodeAdi}");
  print("Http Kodu     :                 ${probeSonucu.statusCode}");
  print("Gecikme Süresi:                 ${probeSonucu.latencyMs}");
  print("Ağ Durumu     :                 ${probeSonucu.baglantiBasariliMi ? "Stabil" : "Kopuk"}");

  //Tek hamlede Değişkenlere parçalama
  final (:nodeAdi, :statusCode, :latencyMs, :baglantiBasariliMi) = probeSonucu;
  print("Değişkenler -> $nodeAdi [Kod: $statusCode, Gecikme: ${latencyMs}ms]");

  final (String podId, int cpuCores, double ramGb) = ("k8s-pod-77x", 8, 32.0);

  print("Pod özeti: $podId | Çekirdek : $cpuCores | Ram: $ramGb GB");
}
