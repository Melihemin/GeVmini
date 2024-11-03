# GeVmini -  For Developers
Proje Raporu: https://github.com/Melihemin/GeVmini/blob/main/hackathonrapor.docx
## Takım Üyeleri

|       | Collaborators             | Roles           | Socials                                                                                         | GitHub                                                                                           |
|-------|----------------------------|------------------|------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
| <img src="https://raw.githubusercontent.com/Melihemin/GeVmini/main/assets/profile_image/inanc-colak.jpg" width="100" height="120"> | İnanç ÇOLAK         | AI Developer    | [<img src="https://raw.githubusercontent.com/Melihemin/GeVmini/main/assets/profile_image/linkedin.png" width="100" height="100">](https://www.linkedin.com/in/colak-inanc12/) | [<img src="https://raw.githubusercontent.com/Melihemin/GeVmini/main/assets/profile_image/github.png" width="100" height="100">](https://github.com/colak-inanc) |
| <img src="https://raw.githubusercontent.com/Melihemin/GeVmini/main/assets/profile_image/melih.jpg" width="100" height="120"> | Melih Emin KILIÇOĞLU | AI Developer    | [<img src="https://raw.githubusercontent.com/Melihemin/GeVmini/main/assets/profile_image/linkedin.png" width="100" height="100">](https://www.linkedin.com/in/melihemin/) | [<img src="https://raw.githubusercontent.com/Melihemin/GeVmini/main/assets/profile_image/github.png" width="100" height="100">](https://github.com/Melihemin) |
| <img src="https://raw.githubusercontent.com/Melihemin/GeVmini/main/assets/profile_image/cagatay-ozbek.jpg" width="100" height="120"> | Yasin Çağatay ÖZBEK  | Mobile Developer | [<img src="https://raw.githubusercontent.com/Melihemin/GeVmini/main/assets/profile_image/linkedin.png" width="100" height="100">](https://www.linkedin.com/in/yasin-çağatay-özbek/) | [<img src="https://raw.githubusercontent.com/Melihemin/GeVmini/main/assets/profile_image/github.png" width="100" height="100">](https://github.com/Cagatay5858) |





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

 ![img-1](https://github.com/user-attachments/assets/67d73f8d-a9d1-4a05-94fb-aa4726700feb)
   ![img-2](https://github.com/user-attachments/assets/ec3d8291-d156-4006-b7ed-c225091a369a)
   ![img-3](https://github.com/user-attachments/assets/b64adcf9-2500-4918-99c9-477acb439672)
   ![img-4](https://github.com/user-attachments/assets/3c68882f-7eee-4945-9fe7-dc66225ab929)


 ![img-5](https://github.com/user-attachments/assets/5d9e036d-108c-4405-a8a4-e3eefe7e8d25)
  ![img-6](https://github.com/user-attachments/assets/6eddf804-cbaf-4d44-9fb7-2ab1adba44c8)
   ![img-7](https://github.com/user-attachments/assets/567e0dd1-8dc4-468b-85d6-cb5915d0a0b9)
  ![img-8](https://github.com/user-attachments/assets/68d679be-1e47-4bdc-83af-eede16a8e7b9)
 


## 🔗 Referanslar
- [Dart Guides](https://dart.dev/guides)
- [Flutter Guides](https://docs.flutter.dev/)
- [Flutter AI Integration](https://flutter.dev/ai)
- [Python Guides](https://www.python.org/doc/)
  
