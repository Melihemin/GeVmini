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
        chat = self.model.start_chat(history=self.history)
        response = chat.send_message(
            f"Kullanıcı cevabını: '{user_answer}' ve doğru cevap: '{correct_answer}' olarak ele al. "
            f"Bu iki cevap arasındaki ilişkiyi derinlemesine incele. Aşağıdaki kriterlere göre benzerlik oranını hesapla ve geri bildirimde bulun."
            "Benzerlik %80 veya daha fazla ise: 'Cevabınız doğrudur. Harika bir iş çıkardınız!'.\n"
            "Benzerlik %60 ile %79 arasındaysa: 'Cevabınız kısmen doğrudur. Biraz daha düşünmenizi öneririm.'\n"
            "Benzerlik %60'dan düşükse: 'Cevabınız yanlıştır. Ama endişelenmeyin, tekrar deneyin.'"
        )
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
        response = chat.send_message(
            f"Konu: {subject}\n"
            f"Soru Sayısı: {question_count}\n"
            f"Zorluk Seviyesi: {level}\n\n"
            "Bu kriterlere göre sorular oluşturun."
        )
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
            f"Konu: {subject}\nZorluk Seviyesi: {level}\n\n"
            "Bu konu ve seviyeye uygun bir soru oluştur."
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
        response = chat.send_message(
            f"Konu: {subject}\nBaşlık: {title}\nZorluk Seviyesi: {level}\nKarakter Limiti: {token}\n\n"
            "Bu kriterlere göre ders anlatımı yap."
        )
        return response.text

    def find_answer(self, question, level):
        """
        Belirtilen soru ve açıklama seviyesine göre detaylı bir yanıt döndürür, konu ile ilgili kaynak önerileri sunar.

        :param question: Yanıtlanacak soru metni.
        :param level: Açıklama seviyesi.
        :return: Model tarafından üretilen yanıt metni.
        """
        chat = self.model.start_chat(history=self.history)
        response = chat.send_message(
            f"{level.capitalize()} bir cevap ver: Soru: '{question}' için {level} seviyesinde bir açıklama yap."
        )
        return response.text

    def guide(self, subject):
        """
        Öğrencilere yönelik rehberlik ve sohbet sağlayan, samimi ve destekleyici bir fonksiyon.

        :param subject: Kullanıcının açtığı sohbet konusu ya da destek istediği alan.
        :return: Samimi, destekleyici ve rehberlik sağlayan bir mesaj.
        """
        chat = self.model.start_chat(history=self.history)
        response = chat.send_message(
            f"Konu: {subject}\n"
            "Sen bir öğrenci destek chatbotusun. Amacın, öğrencilerin sorularını yanıtlamak, onlara rehberlik yapmak ve gerektiğinde dostça bir şekilde sohbet ederek motivasyon sağlamaktır."
        )
        return response.text
