import 'package:flutter/material.dart';
import 'package:gevmini/global.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/images/pp.jpg'), // Replace with your profile picture
              ),*/
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue[800], // Arka plan rengi
                child: Icon(
                  Icons.person, // Profil ikonu
                  size: 60, // İkon boyutu
                  color: Colors.white, // İkon rengi
                ),
              ),
              SizedBox(height: 10),
              Text(
                //'Hoş Geldin, $userName!',
                'Hoş Geldin $userName 👋',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Bu, profil sayfanız.\n\n'
                'Kişiselleştirilmiş ayarlarınıza ve özelliklerinize burada ulaşabilirsiniz.\n\n'
                'Uygulamayı keşfederek rehberlere göz atın, destekle iletişime geçin ve çok daha fazlasını keşfedin!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center, // Apply textAlign here
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Action for exploring guides
                },
                child: Text('Kullanım Rehberini Keşfet 🔍'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  foregroundColor: Colors.white, // Text color
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
