# Dart Programlama Dili

Dart, Google tarafından geliştirilen, özellikle Flutter framework'ü ile birlikte mobil, web ve masaüstü uygulamalarında kullanılan bir programlama dilidir.

Dart'ın önemli özelliklerinden biri, **Just-In-Time (JIT)** ve **Ahead-Of-Time (AOT)** olmak üzere farklı derleme yaklaşımlarını kullanabilmesidir.

Bu iki yaklaşım farklı amaçlara hizmet eder:

* **JIT:** Geliştirme aşamasında hızlı çalışmayı ve hızlı geri bildirim almayı sağlar.
* **AOT:** Uygulama yayınlanırken yüksek çalışma zamanı performansı elde edilmesini sağlar.

---

## 1. Derleyici (Compiler) Nedir?

Bilgisayar programlama dillerinde yazdığımız kod, işlemcinin doğrudan anlayabileceği bir dil değildir.

Örneğin Dart ile:

```dart
int toplam = 10 + 20;
```

şeklinde bir kod yazabiliriz.

Ancak işlemci doğrudan Dart kodunu çalıştırmaz. Yazdığımız kodun, çalıştırılabilir bir forma dönüştürülmesi gerekir.

Bu işlemi gerçekleştiren yazılıma **derleyici (compiler)** denir.

Genel olarak süreç:

```text
Dart Kodu
    ↓
Derleyici (Compiler)
    ↓
Çalıştırılabilir Kod
    ↓
İşlemci
```

şeklinde düşünülebilir.

---

# 2. JIT (Just-In-Time) Derleme

**JIT**, "Just-In-Time" yani **"tam zamanında derleme"** anlamına gelir.

Dart'ın JIT yaklaşımı özellikle **geliştirme aşamasında** kullanılır.

Geliştirici uygulama üzerinde çalışırken kodu sık sık değiştirir. Bu nedenle her değişiklikte bütün uygulamanın baştan derlenmesi ve yeniden başlatılması geliştirme sürecini yavaşlatabilir.

JIT yaklaşımı burada hızlı geri bildirim alınmasına yardımcı olur.

Örneğin:

```dart
Text("Merhaba");
```

kodunu:

```dart
Text("Merhaba Dünya");
```

şeklinde değiştirdiğimizi düşünelim.

Flutter'da **Hot Reload** yaptığımızda değişikliğin uygulamaya hızlı bir şekilde yansımasını sağlayan geliştirme altyapısında Dart'ın JIT özelliklerinden yararlanılır.

Genel olarak:

```text
Kod değiştirildi
      ↓
Hot Reload
      ↓
Değişiklik hızlı şekilde uygulamaya aktarılır
      ↓
Sonuç ekranda görülür
```

Bu nedenle JIT'in en önemli avantajlarından biri **geliştirme hızıdır**.

---

# 3. Hot Reload ile JIT İlişkisi

Flutter'ın en önemli geliştirme özelliklerinden biri **Hot Reload** özelliğidir.

Örneğin bir Flutter uygulamasında:

```dart
Text(
  "Merhaba",
)
```

kodumuz olsun.

Bunu:

```dart
Text(
  "Merhaba Dünya",
)
```

şeklinde değiştirdiğimizde Hot Reload ile uygulamayı tamamen kapatıp tekrar başlatmadan değişikliği görebiliriz.

Bu süreç geliştiriciye hızlı geri bildirim sağlar.

Örneğin:

```text
Kod yaz
   ↓
Hot Reload
   ↓
Sonucu gör
   ↓
Kodu değiştir
   ↓
Hot Reload
   ↓
Sonucu tekrar gör
```

Bu döngü özellikle kullanıcı arayüzü geliştirirken büyük kolaylık sağlar.

> Not: "Sadece değişen satır derlenir" şeklinde düşünmek tam olarak doğru değildir. Hot Reload'ın çalışma mekanizması daha karmaşıktır. Buradaki temel fikir, uygulamanın tamamını sıfırdan başlatmak yerine yapılan değişikliklerin çalışan uygulamaya hızlı şekilde uygulanmasıdır.

---

# 4. AOT (Ahead-Of-Time) Derleme

**AOT**, "Ahead-Of-Time" yani **"önceden derleme"** anlamına gelir.

AOT yaklaşımında kod, uygulama çalıştırılmadan **önce** hedef platformun çalıştırabileceği makine koduna derlenir.

Örneğin bir mobil uygulama yayınlanırken genel mantık:

```text
Dart Kodu
    ↓
AOT Compiler
    ↓
Native Machine Code
    ↓
Mobil Uygulama
    ↓
Android / iOS cihaz
```

şeklindedir.

Bu yaklaşımın amacı, uygulamanın çalışma zamanında yüksek performansla çalışmasını sağlamaktır.

---

# 5. Native Makine Kodu Nedir?

Mobil cihazlarda kullanılan işlemciler, Dart veya Flutter kodunu doğrudan anlamaz.

İşlemcinin anlayabileceği seviyeye yakın olan kodlara **makine kodu (machine code)** denir.

Örneğin modern mobil cihazlarda ARM tabanlı işlemciler oldukça yaygındır.

Basitleştirilmiş şekilde:

```text
Dart
 ↓
AOT Compiler
 ↓
ARM64 Makine Kodu
 ↓
ARM İşlemcisi
```

şeklinde düşünebiliriz.

Buradaki ARM, mobil cihazlarda yaygın olarak kullanılan bir işlemci mimarisidir.

Bu nedenle AOT derleme sayesinde Dart kodu ç
