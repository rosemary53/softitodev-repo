
CREATE TABLE fakulte(
    fakulte_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ad TEXT NOT NULL
);
CREATE TABLE bolum(
    bolum_id INTEGER PRIMARY KEY AUTOINCREMENT,
    adi TEXT NOT NULL,
    fakulte_id INTEGER NOT NULL,
    FOREIGN KEY (fakulte_id) REFERENCES fakulte(fakulte_id)
);

CREATE TABLE ogrenci(
    ogrenci_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ad TEXT NOT NULL,
    soyad TEXT NOT NULL,
    bolum_id INTEGER NOT NULL,
    FOREIGN KEY(bolum_id) REFERENCES bolum(bolum_id)
);

CREATE TABLE ders(
    ders_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ad TEXT NOT NULL,
    kredi INTEGER NOT NULL
);

CREATE TABLE bolum_ders(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ders_id INTEGER NOT NULL,
    bolum_id INTEGER NOT NULL,
    yariyil INTEGER NOT NULL,
    FOREIGN KEY(ders_id) REFERENCES ders(ders_id)
    FOREIGN KEY(bolum_id) REFERENCES bolum(bolum_id)
);

CREATE TABLE ogrenci_ders(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ogrenci_id INTEGER NOT NULL,
    ders_id INTEGER NOT NULL,
    kayit_tarih DATETIME NOT NULL,
    FOREIGN KEY(ders_id) REFERENCES ders(ders_id)
    FOREIGN KEY(ogrenci_id) REFERENCES ogrenci(bolum_id)
);