// functions.dart
import 'package:some_api_library/api.dart'; // Replace with the actual API package you're using

class AidaFunctions {
  final ApiModel model; // This should be initialized with the actual API model

  AidaFunctions(this.model);

  // 1. Find Answer
  Future<String> findAnswer(String question, String level) async {
    final message = """
      ${level} bir cevap ver: Soru: '$question' için $level seviyesinde bir açıklama yap. 
      Kullanıcıya soruyu anlattıktan sonra sorunun hangi konuyla alakalı olduğunu anlat. 
      Bu sorunun konusuyla ilgili 5 tane kaynak öner ve motivasyon yazısı yaz.
    """;

    final chat = model.startChat();
    final response = await chat.sendMessage(message);
    return response.text;
  }

  // 2. Guide
  Future<String> guide(String subject, String feel) async {
    final message = """
      Konu: $subject
      Şu anki hissiyat: $feel

      Bu konuda başarılı olmak için gereken adımları birlikte gözden geçirelim. Öncelikle, bu süreçte karşılaşacağınız zorlukların bir gelişim işareti olduğunu bilin ve kendinizi yargılamadan ilerlemeye çalışın.

      1. **Yol Haritası Oluşturma**: İlk olarak, bu konuda öğrenmeniz gereken temel bilgileri araştırın ve bir plan yapın. Kapsamlı bir şekilde ilerleyebilmek için her gün veya hafta öğrenmeniz gereken hedefleri belirleyin.
      2. **Temel Bilgileri Pekiştirme**: Temel konuları iyice anlamadan ilerlemek zordur. Eğer zorlanıyorsanız, biraz geri dönüp temel bilgileri gözden geçirin.
      3. **Öğrenme Kaynakları**: Bu alanda başarılı olmanızı sağlayacak, çevrimiçi kaynaklar ve eğitimler bulabilirsiniz. Önerilen kaynakları kullanarak güçlü bir altyapı oluşturun.
      4. **Uygulama Yapın ve Pes Etmeyin**: Herhangi bir konuda uzmanlaşmanın yolu, teori ile birlikte uygulama yapmaktır. Her küçük adımı başarı sayın ve asla pes etmeyin.

      Unutmayın, bu süreçte her gün biraz daha güçleniyorsunuz. Zorluklar karşısında yılmayın; her adım sizi hedefinize daha da yaklaştırıyor. Kendinize güvenin!
    """;

    final chat = model.startChat();
    final response = await chat.sendMessage(message);
    return response.text;
  }

  // 3. Lecture
  Future<String> lecture(String subject, String title, String level, int token) async {
    final message = """
      Lütfen '$title' konusunu '$subject' alanında detaylı bir şekilde anlatın.
      Eğer anlatılmasını istenilen konu sayısal ise işlem ve mantık ağırlıklı anlatın,
      Eğer anlatılmasını istenilen konu sözel ise anlatım ağırlıklı olsun.
      Anlatımın seviyesi $level öğrenciler için uygun olmalıdır.
      Açıklamanızın uzunluğu $token karakter olmalıdır.

      Lütfen aşağıdaki kriterleri dikkate alarak konuyu açıklayın:
      1. Kavramların ve fikirlerin netliği.
      2. Verilen bilginin derinliği.
      3. Ana noktaları açıklamak için örnekler kullanılması.
      4. İlgi çekicilik ve katılım düzeyi.
      5. Genel yapı ve tutarlılık.

      Açıklamanızın sonunda, verdiğiniz bilgilerin etkinliğini değerlendirin.
      En son anlattığınız konu hakkında 5 tane türkçe dilinde ve ücretsiz kaynak önerisinde bulunun.
    """;

    final chat = model.startChat();
    final response = await chat.sendMessage(message);
    return response.text;
  }

  // 4. Create Quiz
  Future<String> createQuiz(String subject, int questionCount, String level) async {
    final message = """
      Konu: $subject 
      Zorluk Seviyesi: $level 
      Soru Sayısı: $questionCount

      Lütfen belirtilen konu ve zorluk seviyesine göre yeni nesil ve eski nesil KPSS tarzı sorular oluşturun. 
      Soruların özellikleri: 
      1. Her soru, ilgili konuya dair derinlemesine bilgi gerektirmelidir.
      2. Sorular, çeşitli zorluk seviyelerinde olmalı ve kullanıcıların analiz yapma becerisini ölçmelidir.
      3. Eski nesil sorular, daha geleneksel bir formatta ve net sorulardan oluşmalı; yeni nesil sorular ise eleştirel düşünme ve problem çözme gerektiren durumları içermelidir.
      4. Her sorunun zorluk seviyesini belirten bir açıklama ekleyin.
      5. Soruların geçerliliği ve güncelliği açısından, hem tarihi hem de güncel bilgilerle bağlantılı olmasına dikkat edin.
    """;

    final chat = model.startChat();
    final response = await chat.sendMessage(message);
    return response.text;
  }
}
