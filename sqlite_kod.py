import sqlite3
#Powershell de yeni bir shoppier.db dosyası oluşturdum. Tablo bilgileri cihazda açılan shoppier.db ye kaydedilecek : sqlite3 shoppier.db, .open shoppier.db(veri tabannı geri açtım.)
def list_users(query):
    cursor.execute(query)
    all_users = cursor.fetchall()
    for user in all_users:
       print(user,end="\n")
    print("\n")

# GÖREV 1: VERİ TABANI OLUŞTURMA
baglanti = sqlite3.connect("local_shoppier.db")

cursor = baglanti.cursor()

cursor.execute("""
      
        CREATE TABLE IF NOT EXISTS users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          fullname TEXT NOT NULL,
          email TEXT UNIQUE NOT NULL,
          phone TEXT NOT NULL,
          created_at DATETIME DEFAULT CURRENT_TIMESTAMP
        )
""")

# GÖREV 1.1: 3 ADET kullanıcı ekleyin.
user_fullname =""
user_email=""
user_phone=""

user_count = input("Kaç adet kullanıcı ekleyeceksiniz: ")

for index in range(0,int(user_count)):
    user_fullname = input("Lütfen kullanici adi giriniz: ")
    user_email = input("Lütfen kullanici emaili giriniz: ")
    user_phone = input("Lütfen kullanici telefon numaranizi giriniz:")
    print("\n")

    cursor.execute(""" INSERT INTO users(fullname,email,phone) values(?,?,?)""",(user_fullname,user_email,user_phone))

# GÖREV 1.2: Kullanıcıları listeleyin
select_query = "SELECT *FROM users"
list_users(query=select_query)

# GÖREV 1.3: Kullanıcılardan birinin emailini guncelleyin.
cursor.execute("UPDATE users SET email= 'rmary53@gmail.com' WHERE id = 1")
list_users(query=select_query)

# GÖREV 1.4: Kullanıcılardan birini silin.
cursor.execute("DELETE FROM users WHERE id = ?",(2,))
list_users(query=select_query)

baglanti.commit() # Yapılan güncellemeleri değişiklikleri commit ediyoruz ve veritabanına kalıcı olarak kaydediyoruz.
baglanti.close()

