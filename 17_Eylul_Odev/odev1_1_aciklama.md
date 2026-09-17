## 17 Eylül Ödevi

#### Görev 1.1: 3NF
#### Açıklama:
    Öğrenci, Bölüm ve Ders ilişkilerini 3NF kurallarına uygun olarak normalize edip DDL sorgularını yazın.

#### 1.Varlıklar(Tablolar) arası ilişkiler

#### 1.1.Bölüm-Öğrenci
    1-N: Bir bölümde birden fazla öğrenci bulunabilir. Her öğrenci yalnızca bir bölüme bağlıdır.

#### 1.2.Bölüm-Ders
    M-N: Bir bölümün birden fazla dersi olabilir. Bir ders birçok bölümde verilebilir.

    Örnek : Bilgisayar Mühendisliği Bölümü : Mat2,Algoritmalar
    Elektirik-Elektronik Mühendisliği : Mat2, EMA,Lineer Cebir

##### Burada M-N ilişkisi bolum_ders ara tablosuyla çözülebilir.


#### 1.3.Öğrenci-Ders
    M-N: Bir öğrencinin birden fazla dersi olabilir. Bir ders birden çok öğrenci tarafından alınabilir.

    Örnek: Ali->  Mat2,Veri Yapıları, Veri Tabanı. Ayşe-> Mat2,Fizik2,Nesneye Yönelik Programlama

##### Burada M-N ilişkisi ders_kaydi ara tablosuyla çözülebilir.


#### 2.TABLOLAR

#### 2.1.Bölüm Tablosu

    Sadece bölümün kendisine ait alanlar tabloda tanımlanmıştır. Her bir kaydın/satırın birbirinden benzersiz olması için PK olarak BolumId tanımlanmıştır. İlgili tabloya Şekil 1'de yer verilmiştir.
![BOLUM_TABLOSU](resimler/BOLUM_TABLO.png)
##### Şekil 1.Bölüm Tablosu


#### 2.2.Öğrenci Tablosu

    Öğrenci tablosunda her satırın birbirinden bağımsız olması için öğrenci_id pk olarak belirlendi. Aynı zamanda tabloda verilen alanların yalnızca birincil anahtara bağımlılığı doğrulandı. İlgili tabloya Şekil 2'de yer verilmiştir.
![BOLUM_TABLOSU](resimler/OGRENCI_TABLO.png)
##### Şekil 2.Öğrenci Tablosu

#### 2.3.Ders Tablosu
    Ders tablosuna Şekil 3'de yer verilmiştir.
![BOLUM_TABLOSU](resimler/DERS_TABLO.png)
##### Şekil 3.Ders Tablosu 

#### 2.4.Bölüm_Ders Tablosu
    Hangi dersin hangi bölümlerde okutulduğunu gösteren çoka çok (M:N) çözüm tablosudur. Matematik II dersinin hem Bilgisayar Mühendisliğinde hem de Elektrik-Elektronik Mühendisliğinde yer almasını bu tablo sağlar. Bu durumu sağlayan tabloya Şekil 4'te yer verilmiştir.
![BOLUM_DERS_TABLOSU](resimler/BOLUM_DERS_TABLO.png)
##### Şekil 4.Bolum-Ders Tablosu

#### 2.5.Öğrenci-Ders Tablosu
    Bir öğrencinin birden fazla ders alabilmesini ve bir dersin birden fazla öğrenci tarafından seçilebilmesini sağlayan bağlantı (kesişim) tablosudur. Öğrenciler ve dersler arasındaki bu "çoka çok" ilişkiyi veri tekrarına yol açmadan çözer.İlgili tabloya Şekil 5'te yer verilmiştir.
![OGRENCI_DERS_TABLOSU](resimler/OGRENCI_DERS_TABLO.png)
##### Şekil 5.Öğrenci-Ders Tablosu