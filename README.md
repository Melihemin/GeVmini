# GeVmini -  For Developers

## Takım Üyeleri

|       | Collaborators              | Roles         |    Socials    |    GitHub    |
|-------|------------------------|----------------|---------------|---------------|
| ![image](https://github.com/Melihemin/GeVmini/assets/profile_image/inanc-colak.jpg?raw=true) | İnanç ÇOLAK       | AI Developer     | [![LinkedIn](https://github.com/Melihemin/GeVmini/assets/profile_image/linkedin.png?raw=true)](https://www.linkedin.com/in/colak-inanc12/) | [![GitHub](https://github.com/Melihemin/GeVmini/assets/profile_image/github.png?raw=true)](https://github.com/colak-inanc) |
| ![image](https://github.com/Melihemin/GeVmini/assets/profile_image/melih.png?raw=true) | Melih Emin KILIÇOĞLU| AI Developer      | [![LinkedIn](https://github.com/Melihemin/GeVmini/assets/profile_image/linkedin.png?raw=true)](https://www.linkedin.com/in/melihemin/) | [![GitHub](https://github.com/Melihemin/GeVmini/assets/profile_image/github.png?raw=true)](https://github.com/Melihemin) |
| ![image](https://github.com/Melihemin/GeVmini/assets/profile_image/cagatay-ozbek.jpg?raw=true) | Yasin Çağatay ÖZBEK    | Mobile Developer         | [![LinkedIn](https://github.com/Melihemin/GeVmini/assets/profile_image/linkedin.png?raw=true)](https://www.linkedin.com/in/yasin-çağatay-özbek/) | [![GitHub](https://github.com/Melihemin/GeVmini/assets/profile_image/github.png?raw=true)](https://github.com/Cagatay5858) |


## Uygulama İsmi

**_GeVmini - Eğitim Danışmanı_**

## Uygulama Açıklaması 

GeVmini, öğrenciler için özel olarak tasarlanmış, yapay zeka destekli kişisel eğitim asistanıdır. Öğrencilerin akademik yolculuklarını desteklemek için geliştirilen bu uygulama, konu anlatımı, soru çözme ve rehberlik gibi birçok fonksiyonu bir arada sunar.

## Uygulama Özellikleri
- **📘 Konu Anlatımı**<br>
Öğrenciler, GeVmini'ye bir alan ve konu başlığı seçerek, istedikleri zorluk seviyesinde konu anlatımı talep edebilirler. Bu fonksiyon, verilen başlık hakkında detaylı bir özet oluşturarak öğrenmeyi kolaylaştırır.<br>

- **✍️ Soru Oluşturma**<br>
Uygulama, belirli bir konu ve zorluk seviyesine göre öğrencilerin kendi seviyelerine uygun sorular oluşturmasına olanak tanır. Bu özellik sayesinde öğrenciler, sınavlara daha verimli bir şekilde hazırlanabilir.<br>

- **🧩 Soru Çözümü**<br>
Öğrenciler, bir soru vererek bu sorunun detaylı bir çözümünü alabilirler. Ayrıca, çözümle ilgili açıklamalar sayesinde, öğrenciler soruları nasıl çözebileceklerini daha iyi anlar.<br>

- **💬 Akıllı Chatbot - Akademik Rehber**<br>
GeVmini'nin en önemli özelliklerinden biri, eğitim amaçlı sohbet edilebilen akıllı bir chatbot sunmasıdır. Bu chatbot, öğrencilerin akademik sorularına cevap vermenin yanı sıra, onları motive edici ve rehberlik edici bir rol üstlenir. Örneğin, çalışma tavsiyeleri sunar, moral desteği sağlar veya ders programları ile ilgili önerilerde bulunur.<br>

## 🛠️ Teknik Özellikler <br>
GeVmini, Google Generative AI API'sini kullanarak öğrencilerin taleplerini yanıtlar ve öneriler sunar. Ana fonksiyonlar aşağıda özetlenmiştir:<br>

- **_normalize_answer:_** Kullanıcının cevabını Türkçe karakter uyumuyla normalize eder.
- **_answers_percent:_** Kullanıcı cevabıyla doğru cevap arasındaki benzerlik oranını analiz eder ve geri bildirim sağlar.
- **_create_quiz:_** Belirtilen konu ve zorluk seviyesine göre quiz soruları oluşturur.
- **_create_question:_** İstenilen soru tarzında tek bir soru oluşturur.
- **_lecture:_** Seçilen konu, başlık ve seviyeye göre detaylı ders anlatımı sunar.
- **_find_answer:_** Sorulan soruya detaylı bir yanıt verir ve kaynak önerileri sunar.
- **_guide:_** Öğrencilere rehberlik ve moral desteği sağlayan sohbet asistanı olarak işlev görür.

## 🎯 Hedef Kitle
- **_Yaş Grubu:_** 13 yaş ve üzeri, özellikle ortaokul ve lise seviyesindeki öğrenciler.
- **_Eğitim Tarzı:_**  Akademik destek almak isteyen, soru çözme, konu öğrenme ve rehberlik ihtiyaçları olan öğrenciler.
- **_İlgi Alanları:_**  Eğitim odaklı mobil uygulamaları, kişisel gelişim, akademik başarıyı artırma, yapay zeka destekli çözümler.
- **_Kullanım Amacı:_**  Okuldaki derslere yardımcı olacak konu anlatımı, sınav hazırlığı, soru çözüm desteği ve rehberlik hizmetlerine ihtiyaç duyan öğrenciler.

## 🚀 Kurulum
- Projeyi klonlayın :
```
git clone https://github.com/kullanıcıadı/gevmini.git
```
- Gereken bağımlılıkları kurun :
```
pip install -r requirements.txt
```
- **_Google Generative AI API_** anahtarınızı *'api_key'* değişkenine atayın ve uygun *'model_name'* ile birlikte kullanın.

- Uygulamayı başlatın.

## 💡 Kullanım
GeVmini, öğrencilerin akademik gelişimlerine katkıda bulunmayı amaçlar. Uygulama, çeşitli konularda özet oluşturmak, soru çözmek, yeni sorular oluşturmak ve öğrencileri motive eden bir chatbot sunmak için idealdir.

## 📈 Gelecek Planları
- **_Daha Gelişmiş Chatbot Özellikleri:_** Öğrencilerin akademik başarılarını arttırmak için daha detaylı ve akıllı sohbet seçenekleri eklemek.
- **_Genişletilmiş Soru Veritabanı:_** Farklı konu başlıkları ve seviyeler için daha fazla soru çeşidi sağlamak.
- **_Kapsamlı Raporlama Özellikleri:_** Öğrencilerin öğrenme süreçlerini takip edebilecekleri bir performans analiz bölümü.<br>

## 📸 Proje Görselleri 

| ![img-1](https://github.com/Melihemin/GeVmini/assets/application_image/1.png?raw=true)  | ![img-2](https://github.com/Melihemin/GeVmini/assets/application_image/2.png?raw=true)  | ![img-3](https://github.com/Melihemin/GeVmini/assets/application_image/3.png?raw=true)  | ![img-4](https://github.com/Melihemin/GeVmini/assets/application_image/4.png?raw=true) |

| ![img-5](https://github.com/Melihemin/GeVmini/assets/application_image/5.png?raw=true)  | ![img-6](https://github.com/Melihemin/GeVmini/assets/application_image/6.png?raw=true)   | ![img-7](https://github.com/Melihemin/GeVmini/assets/application_image/7.png?raw=true)  | ![img-8](https://github.com/Melihemin/GeVmini/assets/application_image/8.png?raw=true) |


## 🔗 Referanslar
- [Dart Guides](https://dart.dev/guides)
- [Flutter Guides](https://docs.flutter.dev/)
- [Flutter AI Integration](https://flutter.dev/ai)
- [Python Guides](https://www.python.org/doc/)
  
