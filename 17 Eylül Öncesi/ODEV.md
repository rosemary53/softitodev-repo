#
# Kahve Mobil Uygulaması
# Görev1

### ADIM 1: Başla
### ADIM 2: Kullanıcı uygulamayı açar. 
    --> EĞER cihazda süresi dolmamış geçerli bir oturum tokenı var İSE kullanıcıyı anasayfaya yönlendir ve ADIM 4'e gönder.

    --> DEĞİLSE kullanıcıyı giriş ekranına yönlendir ve ADIM 3'E geç.
### ADIM 3: Giriş Ekranı Durumları
    --> EĞER internet bağlantısı yok İSE "internet bağlantısı yok,giriş yapmak için internetiniz açın" uyarısı yap.

    --> DEĞİLSE kullanıcı bilgilerini gir
       --> EĞER kullanıcı bilgileri doğruysa anasayfaya yönlendir ve ADIM 4'e geç.

       --> DEĞİLSE "kullanıcı bilgileriniz yanlıştır." uyarısını göster ve ADIM 3'e dön.
### ADIM 4: Anasayfanın Yüklenmesi
    --> EĞER internet bağlantısı yok İSE
       --> Yerel veri tabanındaki son kaydedilmiş ürün listesini yükle.
       --> Kullanıcı ürünlerini incele ve ADIM 5'e geç.
    
    --> DEĞİLSE bulut veri tabanından güncel ürünleri, sepet listesini, kullanıcı cüzdan bakiye bilgilerini çek.
       --> Ekrana verileri listele ve ADIM 5'e geç.
### ADIM 5: Ürünleri internet ve stok durumuna göre seçme
    --> Kullanıcı ürün seçip sepete eklemek isterse
    --> EĞER internet bağlantısı yok İSE "internet bağlantınız yok, sepete ekleyemezsini" uyarısı ver.

    --> DEĞİLSE ürün stok bilgisine bak
       --> EĞER stok > 0 ise ürünü sepete ekle

       --> DEĞİLSE "Maalesef ürün stokta yok " uyarısı ver.
### ADIM 6: Sepet Sayfası internet durumu/ sepetin boş/dolu olma durumu
    -->EĞER internet bağlantısı yok İSE ekranda "çevrimdışısınız sepetinizi görüntülüyemiyoruz." uyarısı ver.

    --> DEĞİLSE 
        --> Buluttan gelen en güncel sepet listesini çek
        --> EĞER sepet listesi boş İSE "henüz sepete bir şey eklemediniz." yazısını ekranda göster.

        --> DEĞİLSE ekrana güncel sepet verilerini listele. Siparişi tamamla butonuna yer ver.
### ADIM 7: Siparişi Tamamla İşlemleri
    --> EĞER kullanıcı cüzdan bakiyesi >= sepet tutar İSE 
        --> Siparişi onayla.
        --> Kullanıcı cüzdan bakiyesini sepet tutarı miktarında azalt.
        --> Yeni kullanıcı bakiyesini veri tabanına kaydet.
        --> "Siparişiniz başarıyla alındı." mesajı gönder.
        --> BİTİR.
    
    --> DEĞİLSE
        --> "Bakiyeniz yetersiz, lütfen bakiye yükleyin." uyarısı ver.

### BİTİR

#
# GÖREV 2

### 1.Sipariş Oluşturma Endpointi
    --> HTTP METHOD: POST
    --> URL/ENDPOINT: /api/v1/siparisler
    --> HEADER: Authorization: Bearer<token>
                Content-type: application/json
    --> REQUEST BODY: {
                        "siparisUrunleri":[
                            {
                                "urunId":10,
                                "urunAdi": "Ice Caramel Latte",
                                "urunAdeti": 2,
                                "birimFiyat": 185
                            },
                            {
                                "urunId":20,
                                "urunAdi": "Bluberry Frozen",
                                "urunAdeti": 3,
                                "birimFiyat": 200
                            }
                        ],
                        "toplamTutar": 970
                      }
    --> Başarılı Sonuç HTTP Durum Kodu: 201 Created 
    --> Kullanıcı giriş yapmamışsa dönecek HTTP durum kodu: 401 Unauthorized
### 2.Cüzdan Bakiye Sorgulama
    --> HTTP METHOD: GET
    --> URL/ENDPOINT: /api/v1/cuzdan/bakiye
 
    --> RESPONSE BODY: {
                          "basariliMi": True,
                          "veri":{
                            "bakiye": 1.000.000,
                            "paraBirimi": "TRY"
                          }
                        
                       }
    --> Başarılı Sonuç HTTP Durum Kodu: 200 OK (Get methodlarında geriye hep döner.)
    --> SUNUCUDA BEKLENMEYEN BİR HATA MEYDANA GELİRSE GERİYE DÖNEN DURUM KODU: 500 Internal Server Error.

### 3.Mülakat Sorusu: GET ve POST isteklerinden hangisi eşgüdümlü bir istektir?
    --> IDEMPONENT(Eşgüdümlü): Sunucuya ne kadar istek atarsak atalım verinin sonuç değişmiyor.

    --> GET: Sepete eklediğimiz ürünleri 10 defa da 100 defa da listelesek ekrandaki çıktı değişmeyecek. Bundan dolayı eşgüdümlüdür.

    --> POST: Siparis isteğini bir kez yapsak bakiyemiz bu oranda düşecek iki kez yapsak bakiyemiz daha da fazla azalacak. Yani POST isteklerinde her durumda verinin durumu hep değişecek. Bundan dolayı eşgüdümlü değildir diyebiliriz.

#
# GÖREV 3
### 
     --> class KahveSiparisYoneticisi {
            void sepetHesaplaVeIndirimUygula() { ... }
            void krediKartindanTahsilatYap() { ... }
            void siparisiVeritabaninaKaydet() { ... }
            void musteriyiSmsIleBilgilendir() { ... }
            double indirimHesapla(String musteriTipi, double tutar) {
               if (musteriTipi == "OGRENCI") return tutar * 0.80;
               else if (musteriTipi == "OGRETMEN") return tutar * 0.85;
               else return tutar;
            }
         }
### Soru 1: Bu sınıfta Single Responsibility Principle (SRP - Tek Sorumluluk) nasıl ihlal edilmiştir? Sınıfı hangi küçük parçalara
      --> SRP'ye göre her sınıfın tek bir sorumluluğu olmalıdır.
      --> Bu sınıfta sms, veri tabanı, siparis vb. birden fazla birbirinden bağımsız işlem var. Bu durum SRP ihlaline sebep olur.
      --> Sınıfı sadece kendi sorumluluğuna ait 4 küçük sınıfa bölmeliyiz: SepetServisi, OdemeServisi, VeritabaniServisi, SmsServisi.
### 2. indirimHesapla fonksiyonunda yarın yeni bir müşteri tipi(örneğin"DOKTOR" ) geldiğinde if-else kodunu değiştirmek zorunda kalmak hangi SOLID prensibine aykırıdır?
      --> Kod yeni özellikler eklemeye açık ama değiştirmeye kapalı olmalıdır. Ancak bu kodda yeni özellik eklendikçe if else sayısı da artmış yani değişken olmuş bu da DIP'i ihlal eder.
      --> IF-else yapısından kurtulup interface tabanlı bir mekanizma geliştirmeliyiz.