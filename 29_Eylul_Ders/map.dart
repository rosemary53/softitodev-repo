void main() {
  print("Map metriklerini görelim.");

  /*
    İlk map'in key kısmı string, value kısmı Map
     key = "auth-api"
     value={
       key: "auth-api" value : {Map}
      "port": 8081,
      "saglik": "Healty",
      "ressartSayisi": 0,
      "bellekKullanicimiMB": 384.5,
      "otonomOlcekleme": true,
    },

    İkinci mapin içindeki 
    key tipi string alacağı değerler biribirinden farklı bundan dolayı dynamic
   */
  final Map<String, Map<String, dynamic>> mikroservisRehberi = {
    "auth-api": {
      //key: "auth-api" value : {Map}
      "port": 8081,
      "saglik": "Healty",
      "restartSayisi": 0,
      "bellekKullanimiMB": 384.5,
      "otonomOlcekleme": true,
    },
    "payment-gateway": {
      "port": 8082,
      "saglik": "Degraded",
      "restartSayisi": 4,
      "bellekKullanimiMB": 1280.0,
      "otonomOlcekleme": false
    }
  };

  //mikroservis mapini görüntüle
  print("Map: ${mikroservisRehberi["payment-gateway"]}");

  //Map'e yeni servis ekleme (putIFabsent ile çakışmasız ekleme)
  mikroservisRehberi.putIfAbsent(
      "reporting-worker",
      () =>
          {"port": 9091, "saglik": "Healty", "restartSayisi": 1, "bellekKullanimiMB": 512.0, "otonomOlcekleme": true});

  //Metrik güncelleme
  if (mikroservisRehberi.containsKey("payment-gateway")) {
    mikroservisRehberi["payment-gateway"]!["restartSayisi"] =
        (mikroservisRehberi["payment-gateway"]!["restartSayisi"] as int) + 1;
  }

  print("Güncel Servis Durum Raporu");
  print("--------------------------");

  for (var entry in mikroservisRehberi.entries) {
    final String servis = entry.key; // mikroservisRehberi mapinde keyin tipi Stringdi.
    final Map<String, dynamic> ozet = entry.value; // mikroserviste value mizin tipi Mapti
    final String saglik = ozet['saglik']; //ozet bir map ve key-value çiftleri içeriyor.
    final String durumRozet = saglik == "Healty"
        ? "Ok"
        : "Alert"; //sağlık değeri Healty' eşitse Ok değerini geriye döndür. Değilse Alert geriye döndür.

    print(
        "$durumRozet ${servis.padRight(10)} | Port: ${ozet['port']} | Ram: ${ozet['bellekKullanimiMB']} | Restart: ${ozet['restartSayisi']}");
  }
}
