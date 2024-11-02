import google.generativeai as genai
import re



class Gevmini:
    
    """
    Gevmini sınıfı, Google Generative AI API'sini kullanarak kullanıcı cevaplarını değerlendirmek, 
    quiz soruları oluşturmak ve ders anlatımları yapmak için geliştirilmiştir.
    """
    
    history = [
        {"role": "user", "parts": "Merhaba, sen soru çözmek, soru oluşturmak, kullanıcılarla ders hakkında sohbet etmek ve onlara rehberlik sağlamak için buradasın. Amacının dışına çıkmadan yardımcı ol."},
        {"role": "model", "parts": "Merhaba! Derslerde rehberlik, soruların çözümü veya yeni sorular oluşturma konusunda yardımcı olmaktan mutluluk duyarım. Hangi konuda destek almak istersiniz?"}
    ]

    """
    Sohbet geçmişi, modelin yalnızca belirli bir amaca odaklanmasını sağlamak için düzenlenmiştir.

    Amaç:
    - Modelin, kullanıcılarla ders odaklı rehberlik, soru çözümü ve soru oluşturma konusunda etkileşimde bulunmasını sağlamak.
    - Modelin, sohbet süresince uygun olmayan veya amacın dışına çıkan konulara yönelmesini engellemek.

    Yapı:
    - Kullanıcı rolündeki ilk mesaj, modelin yalnızca ders odaklı rehberlik, soru çözümü ve soru oluşturma ile sınırlandırıldığını belirtir.
    - Model rolündeki yanıt, kullanıcıyı destekleyeceği alanlarda net bir rehberlik sunmak için hazırlık yapar.
    """

    def __init__(self, api_key, model_name):
        """
        Sınıfın yapıcı metodu. API anahtarını ve model adını alarak gerekli ayarları yapar.

        :param api_key: Google Generative AI API'sine erişim için gerekli anahtar.
        :param model_name: Kullanılacak modelin adı.
        """
        self.api_key = api_key
        self.model_name = model_name

        genai.configure(api_key=self.api_key)
        self.model = genai.GenerativeModel(self.model_name)

    def normalize_answer(self, text, lang):
        """
        Kullanıcının cevabını normalize eder. Türkçe karakterleri ve özel karakterleri temizler.

        :param text: Normalleştirilecek metin.
        :param lang: Metnin dili (şu an yalnızca 'tr' veya 'TR' desteklenmektedir).
        :return: Normalleştirilmiş metin.
        """
        if lang == "tr" or lang == "TR":
            text = text.lower()
            text = re.sub(r'[aeıioöuü]', '', text)
            text = re.sub(r'\W+', '', text)
            return text.strip()

    def answers_percent(self, user_answer, correct_answer):
        """
        Kullanıcı cevabı ile doğru cevap arasındaki benzerlik oranını hesaplar ve geri bildirim verir.

        :param user_answer: Kullanıcının verdiği cevap.
        :param correct_answer: Doğru cevap.
        :return: Benzerlik oranı ve geri bildirim.
        """
        answers = [user_answer, correct_answer]
        
        chat = self.model.start_chat(history=self.history)
        response = chat.send_message(f"Kullanıcı cevabını: '{user_answer}' ve doğru cevap: '{correct_answer}' olarak ele al. "
        f"Bu iki cevap arasındaki ilişkiyi derinlemesine incele. Aşağıdaki kriterlere göre benzerlik oranını hesapla ve geri bildirimde bulun: \n\n"
        f"1. *Bağlam*: Cevapların içerdiği tarih, kültür veya olay bağlamlarını değerlendir. Cevaplar hangi durumlarda geçerli? \n"
        f"2. *Anlam*: Cevapların anlam derinliğini incele. Kullanıcı cevabının doğru cevapla örtüşen veya çelişen yönlerini belirle. \n"
        f"3. *Duygu ve Niyet*: Kullanıcının yanıtında duygu veya niyet var mı? Cevaplar, belirli bir duygusal bağlam veya amaç taşıyor mu? \n"
        f"4. *Kelime Seçimi*: Kullanılan kelimelerin ve terimlerin benzerliğini incele. İki cevaptaki terimler arasında anlam ilişkisi var mı? \n"
        f"5. *Mantıksal İlişkiler*: Cevaplar arasındaki mantıksal ilişkileri değerlendir. Bir cevabın diğerine göre daha mantıklı veya tutarlı bir açıklama sunup sunmadığını kontrol et. \n"
        f"6. *Örnekleme*: Kullanıcı cevabında verdiği örnekler, doğru cevabın gerektirdiği örneklerle ne kadar örtüşüyor? Örnekler aracılığıyla cevapların geçerliliğini değerlendir. \n\n"
        f"Elde edilen yüzdelik değerine göre geri bildirimde bulun: \n"
        f"1. Eğer benzerlik %80 veya daha fazla ise, 'Cevabınız doğrudur. Harika bir iş çıkardınız! Geri bildirimde bulunmamı ister misiniz?' \n"
        f"2. Eğer benzerlik %60 ile %79 arasında ise, 'Cevabınız kısmen doğrudur. Biraz daha düşünmenizi öneririm. Belirli noktaları gözden geçirebilir misiniz?' \n"
        f"3. Eğer benzerlik %60'dan düşükse, 'Cevabınız yanlıştır. Ama endişelenmeyin, bu harika bir öğrenme fırsatı! Lütfen tekrar deneyin ve hangi noktaların gözden kaçtığını düşünün.' \n"
        f"Yanıtlar arasındaki ilişkiyi daha da açıklayıcı hale getirin. Cevaplar arasındaki bağlantıları ve çelişkileri belirterek kullanıcıyı yönlendirin. "
        f"Yanıtınızı bu kriterlere göre düzenleyin."
        f"Tum bu degerlendirmeleri ozetle kullaniciya sadece ozeti ver"
        f"En son ise kullaniciya bu soruyu yapabilecegini hatirlat ve daha fazla cabalamasi icin motive et")
        return response.text

    def create_quiz(self, subject, question_count, level):
        """
        Belirtilen konu ve zorluk seviyesine göre KPSS tarzı sorular oluşturur.

        :param subject: Soruların oluşturulacağı konu.
        :param question_count: Oluşturulacak soru sayısı.
        :param level: Soruların zorluk seviyesi.
        :return: Oluşturulan sorular.
        """
        chat = self.model.start_chat(history=self.history)
        response = chat.send_message(f"Konu: {subject} \n"
        f"Zorluk Seviyesi: {level} \n"
        f"Soru Sayısı: {question_count} \n\n"
        f"Lütfen belirtilen konu ve zorluk seviyesine göre yeni nesil ve eski nesil KPSS tarzı sorular oluşturun. "
        f"Soruların özellikleri: \n"
        f"1. Her soru, ilgili konuya dair derinlemesine bilgi gerektirmelidir. \n"
        f"2. Sorular, çeşitli zorluk seviyelerinde olmalı ve kullanıcıların analiz yapma becerisini ölçmelidir. \n"
        f"3. Eski nesil sorular, daha geleneksel bir formatta ve net sorulardan oluşmalı; yeni nesil sorular ise eleştirel düşünme ve problem çözme gerektiren durumları içermelidir. \n"
        f"4. Her sorunun zorluk seviyesini belirten bir açıklama ekleyin. \n"
        f"5. Soruların geçerliliği ve güncelliği açısından, hem tarihi hem de güncel bilgilerle bağlantılı olmasına dikkat edin. \n"
        f"Örnek olarak, aşağıdaki gibi sorular oluşturun: \n"
        f"1. [Soru 1] - [Zorluk Seviyesi Açıklaması] \n"
        f"2. [Soru 2] - [Zorluk Seviyesi Açıklaması] \n"
        f"3. [Soru 3] - [Zorluk Seviyesi Açıklaması] \n"
        f"(Devam eden sorular için aynı formatı izleyin.)")

        return response.text


    
    def create_question(self, subject, level):
        """
        Belirtilen konu ve zorluk seviyesine göre KPSS tarzı bir soru oluşturur.

        :param subject: Sorunun oluşturulacağı konu.
        :param level: Sorunun zorluk seviyesi.
        :return: Oluşturulan soru.
        """
        chat = self.model.start_chat(history=self.history)
        response = chat.send_message(
            f"Konu: {subject} \n"
            f"Zorluk Seviyesi: {level} \n\n"
            f"Lütfen belirtilen konu ve zorluk seviyesine göre KPSS tarzında tek bir soru oluşturun. "
            f"Sorunun özellikleri: \n"
            f"1. Soru, ilgili konuya dair derinlemesine bilgi gerektirmelidir. \n"
            f"2. Sorunun zorluk seviyesini belirten bir açıklama ekleyin. \n"
            f"3. Soru, eleştirel düşünme ve problem çözme gerektiren durumları içermelidir. \n"
            f"4. Sorunun geçerliliği ve güncelliği açısından, hem tarihi hem de güncel bilgilerle bağlantılı olmasına dikkat edin. \n"
            f"Soru formatı: \n"
            f"[Soru] - [Zorluk Seviyesi Açıklaması] \n"
            f"Lütfen sorunun cevabını verin ve detaylı bir şekilde açıklayın."
        )

        return response.text



    
    
    def lecture(self, subject, title, level, token):
        """
        Belirtilen konu hakkında detaylı bir ders anlatımı yapar.

        :param subject: Dersin ait olduğu alan.
        :param title: Anlatılacak konunun başlığı.
        :param level: Dersin zorluk seviyesi.
        :param token: Açıklamanın maksimum karakter sayısı.
        :return: Dersin detaylı anlatımı.
        """
        chat = self.model.start_chat(history=self.history)

        response = chat.send_message(f"Lütfen '{title}' konusunu '{subject}' alanında detaylı bir şekilde anlatın."
        f"Eğer anlatılmasını istenilen konu sayısal ise işlem ve mantık ağırlıklı anlat"
        f"Eğer anlatılmasını istenilen konu sözel ise anlatım ağırlıklı olsun"
        f"Anlatımın seviyesi {level} öğrenciler için uygun olmalıdır. "
        f"Açıklamanızın uzunluğu {token} karakter olmalıdır. "
        f"Lütfen aşağıdaki kriterleri dikkate alarak konuyu açıklayın:\n"
        f"1. Kavramların ve fikirlerin netliği.\n"
        f"2. Verilen bilginin derinliği.\n"
        f"3. Ana noktaları açıklamak için örnekler kullanılması.\n"
        f"4. İlgi çekicilik ve katılım düzeyi.\n"
        f"5. Genel yapı ve tutarlılık.\n"
        f"Açıklamanızın sonunda, verdiğiniz bilgilerin etkinliğini değerlendirin."
        f"En son anlattığınız konu hakkında 5 tane türkçe dilinde ve ücretsiz kaynak önerisinde bulunun")

        return response.text


    def find_answer(self,question, level):
        """
        Belirtilen soru ve açıklama seviyesine göre detaylı bir yanıt döndürür, konu ile ilgili kaynak önerileri sunar.

        Bu fonksiyon, kullanıcının sorduğu soruya ve belirtilen açıklama seviyesine göre bir model sohbeti başlatır.
        Model, soruya uygun seviyede bir açıklama yapar, konuyla ilgili beş kaynak önerir ve kullanıcının motivasyonunu 
        artıracak bir yazı ekler.

        Args:
            question (str): Yanıtlanacak soru metni.
            level (str): Açıklama seviyesi, örneğin "temel", "orta" veya "ileri".

        Returns:
            str: Model tarafından üretilen yanıt metni. Yanıt, soruya dair açıklamayı, konuyla ilişkisini, kaynak önerilerini ve bir motivasyon yazısını içerir.
        """
        chat = self.model.start_chat(history=self.history)
        

        # Detaylı bir prompt oluşturma
        response = chat.send_message(
            f"{level.capitalize()} bir cevap ver: Soru: '{question}' için {level} seviyesinde bir açıklama yap. "
            f"Kullanıcıya soruyu anlattıktan sonra sorunun hangi konuyla alakalı olduğunu anlat. "
            f"Bu sorunun konusuyla ilgili 5 tane kaynak öner ve motivasyon yazısı yaz."
        )
        
        return response.text


    def guide(self, subject, feel):
        """
        Kullanıcıya seçilen konu doğrultusunda psikolojik ve ders anlamında rehberlik sağlar.

        Bu fonksiyon, kullanıcının belirttiği konu ve ruh haline göre motive edici bir yol haritası sunar. 
        Kullanıcının başarıya ulaşması için gerekli adımları içeren bir rehberlik sağlar, öğrenme sürecinde karşılaşabileceği 
        zorluklara karşı motive edici bir bakış açısı kazandırır ve hedeflerine ulaşmak için pes etmeden ilerlemesini teşvik eder.

        :param subject: Kullanıcının destek istediği konu başlığı.
        :param feel: Kullanıcının mevcut ruh hali ya da hissiyatı (örneğin, motivasyonsuz, heyecanlı, stresli).
        :return: Rehberlik ve motivasyon sağlayan bir mesaj.
        """
        
        chat = self.model.start_chat(history=self.history)

        response = chat.send_message(
            f"Konu: {subject}\n"
            f"Şu anki hissiyat: {feel}\n\n"
            "Bu konuda başarılı olmak için gereken adımları birlikte gözden geçirelim. Öncelikle, bu süreçte karşılaşacağınız zorlukların bir gelişim işareti olduğunu bilin ve kendinizi yargılamadan ilerlemeye çalışın.\n\n"
            "1. *Yol Haritası Oluşturma*: İlk olarak, bu konuda öğrenmeniz gereken temel bilgileri araştırın ve bir plan yapın. Kapsamlı bir şekilde ilerleyebilmek için her gün veya hafta öğrenmeniz gereken hedefleri belirleyin.\n\n"
            "2. *Temel Bilgileri Pekiştirme*: Temel konuları iyice anlamadan ilerlemek zordur. Eğer zorlanıyorsanız, biraz geri dönüp temel bilgileri gözden geçirin.\n\n"
            "3. *Öğrenme Kaynakları*: Bu alanda başarılı olmanızı sağlayacak, çevrimiçi kaynaklar ve eğitimler bulabilirsiniz. Önerilen kaynakları kullanarak güçlü bir altyapı oluşturun.\n\n"
            "4. *Uygulama Yapın ve Pes Etmeyin*: Herhangi bir konuda uzmanlaşmanın yolu, teori ile birlikte uygulama yapmaktır. Her küçük adımı başarı sayın ve asla pes etmeyin.\n\n"
            "Unutmayın, bu süreçte her gün biraz daha güçleniyorsunuz. Zorluklar karşısında yılmayın; her adım sizi hedefinize daha da yaklaştırıyor. Kendinize güvenin!"
        )

        return response.text