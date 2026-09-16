## Sqlite Ödevi

### Görev 1.1: Veri tabanı ve tablo oluşturma

local_shoppier.db adında bir veri tabanı oluşturuldu. Bu veri tabanına users adında tablo eklendi. Yapılan işlemlere ait kod bloğuna Şekil 1'de yer verildi.

-> Veri tabanı = local_shoppier.db

-> Tablo = users

![SQL Veri tabanı ve tablo oluşturma](images/db_table_create.png)
#### Şekil 1.Veri tabani ve Tablo Oluşturma Kodları

### GÖREV 1.2: 3 adet kullanıcı ekleme

Bu görevde users tablosuna kaç adet kullanıcı eklenmesi gerektiği bilgisi dinamik bir şekilde alındı ardından bu kullanıcı sayısı kadar işlem yapan bir for döngüsü kuruldu. For döngüsü içerisinde de users tablosunda boş bırakılması yasak yani NOT NULL olan özellikler yine dinamik olarak alındı. Alınan bu veriler users tablosuna kaydedildi. Yapılan işlemleri gerçekleştiren python kodlarına ve çalışan koda ait çıktılara Şekil 2'de yer verildi.

![SQL Kullanıcı Ekleme](images/insert_user.png)
#### Şekil 2.Kullanıcı Ekleme Kaynak Kodu Çıktısı

### GÖREV 1.3: Kullanıcıları Listeleme

users tablosunda bulunan verileri çekmek için kullanılan sorgu koduna Şekil 3'te yer verilmiştir.

![SQL Kullanıcı Listeleme Sorgusu](images/select_user.png)
![SQL Tablodaki tüm kullanıcıların listelenmesi](images/select.png)
#### Şekil 3.Kullanıcı Listeleme Sorgu Kodu Çıktısı

### GÖREV 1.4: Kullanıcının email bilgisini güncelleme

Ön Bilgi: Bir veri tabanında tabloda bulunan varlığa ait bir alan yani özellik güncellenmek isterse UPDATE komutu kullanılır. 

users tablosunda belirli bir kullanıcıya ait email bilgisini güncelleme sorgusu koduna Şekil 4'te yer verilmiştir. 

![SQL Kullanıcı alan güncelleme sorgu kodu](images/update.png)
#### Şekil 4.Varlık örneğine ait özelliğin güncellenmesindeki sorgu kodu

Güncellendikten sonraki kullanıcı listesine ise Şekil 5'te yer verilmiştir.


![SQL Güncel kullanıcı listesi](images/update_select.png)
#### Şekil 5.Güncel kullanıcı listesi

### GÖREV 1.5: Kullanıcının tablodan silinmesi
Ön Bilgi: Bir veri tabanında tabloda bulunan varlık örneğini yani kullanıcıyı silmek için kullanılan komut DELETE komutudur. 

users tablosunda belirli bir kullanıcıyı silmede kullanılan sorgu koduna Şekil 6'da yer verilmiştir.
![SQL Kullanıcıyı silen sorgu kodu](images/delete.png)
#### Şekil 6.Kullanıcıyı silmede kullanılan sorgu kodu

Silme işlemi gerçekleştikten sonra güncel kullanıcı listesi çıktısıne ise Şekil 7'de yer verilmiştir.

![SQL Kullanıcıyı silen sorgu kodu](images/delete_after_select.png)
#### Şekil 7.Silme işleminden sonraki güncel kullanıcı listesi

#
### GÖREV 2:
Kullanıcılara ait users tablosuna ve kullanıcıların siparişlerinin bulunduğu tabloya şekil 8'de yer verilmiştir.

![SQL Users ve Orders Tablosundaki İlişki](images/users_orders.jpg)
#### Şekil 8.Users ve Orders Tablolari

#### INNER JOIN Gereksinimi açıklama
'users' tablosundan kullaniciAdi, email bilgisi çekilip listelenmek istiyor.

'orders' tablosundan ise ilgili kullanıcıya ait siparişin sipariş numarası alınıp listelenmek istiyor.

Bu iki tablodan alınması gereken alanları listeleyebilmek için de iki tablo arasında bir ilişki kurulması gerekir. Yani bir tabloda melisa_kaya adlı kullanıcısı varsa diğer tabloda melisa_kaya adlı kullanıcısına ait kayıt/satır eşleştirilip o satırdaki istenen alanlar iki tablodan alınıp ekrana çıktı olarak verilmelidir.
İşte bu isteği gerçekleştirmek için kullanılan komut ise INNER JOIN'dir.

#### SQL INNER JOIN SORGUSU

    SELECT users.kullaniciAdi,users.email,orders.siparis_numarasi FROM users 
    INNER JOIN orders 
    ON users.kullanici_id = orders.kullanici_id
    
#### SORGUNUN Parça Parça Açıklanması

     SELECT users.kullaniciAdi, users.email, orders.siparis_numarasi

    Açıklama:   Listelenmek istenen alanlar hangi tabloda bulunuyorsa burada tabloAdi.sutunAdi şeklinde belirtilmeli.
    
    FROM users

    Açıklama: Sorguda ilk dikkate alınan tablomuz users tablosu

    INNER JOIN orders 

    Açıklama: orders tablosunu da bu işleme tabi tut yani ilişkilendir.

    ON users.kullanici_id = orders.kullanici_id

    Açıklama: iki tablodaki değerleri karşılaştır .Eşit olanları eşleştir ve ilgili satırı geri döndür. Geriye dönen satırdanda geriye en başta istenen alanları döndür.

    Örneğin : users tablosundan 2.satır + orders tablosundan 2.satır döner. Ardından users tablosundan dönen satırdan kullaniciAdi,email orders tablosundan dönen satırdan siparis_numarasi alani dikkate alınır.