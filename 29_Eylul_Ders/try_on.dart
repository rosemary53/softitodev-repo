class Cloud implements Exception {
  final String hataKodu;
  final String mesaj;
  final DateTime zaman = DateTime.now();

  Cloud(this.hataKodu, this.mesaj);

  @override
  String toString() => "[$hataKodu] $mesaj ($zaman)";
}

class CpuOverload extends Cloud {
  final double mevcutCpu;
  final double limit;

  CpuOverload({required this.mevcutCpu, required this.limit})
      : super("Err_Cpu_overload", "Cpu eşik limitini ($limit) aştı: $mevcutCpu%");
}

class NodeUnavailable extends Cloud {
  final String nodeId;

  NodeUnavailable(this.nodeId) : super("Err_node_ofline", "Yanıt vermiyor: $nodeId");
}

void podKaynaginiTahsilEt(String podAdi, double talepEdilenCpu, double sistemKalanCpu) {
  if (talepEdilenCpu <= 0) {
    throw Cloud("Err_invalid_parameter", "Talep edilen Cpu pozitif bir değer olmalıdır.");
  }
  if (talepEdilenCpu > sistemKalanCpu) {
    throw CpuOverload(mevcutCpu: 100 - sistemKalanCpu + talepEdilenCpu, limit: 100.0);
  }

  print("Pod [$podAdi] başarıyla tahsis edildi: Klan boş cpu: ${sistemKalanCpu - talepEdilenCpu}");
}

void main() {
  print("Yönetim Paneli");

  //başarılı tahsis
  try {
    podKaynaginiTahsilEt("ingress-controller", 15.0, 40);
  } catch (err) {
    print("Hata: $err");
  }

  //Cpu Aşımı Tahsis
  try {
    podKaynaginiTahsilEt("ai-training", 60.0, 50.0);
  } on CpuOverload catch (err) {
    print("Cpu Hatası yakalandı.");
    print("Hata kodu : ${err.hataKodu}");
    print("Mesaj: ${err.mesaj}");
    print("Aksiyon: Otomatik Aws Açma İsteiği Gönderildi.");
  } on Cloud catch (err) {
    print("Bulut hatası : ${err.mesaj}");
  } catch (err, stackTrace) {
    print("Bilinmedik Sistem Hatasi $err");
  } finally {
    print("Pod tahsis günlüğü pakatıldı.");
  }
}
