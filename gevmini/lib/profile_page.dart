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
    return Scaffold(body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              //backgroundImage: AssetImage('assets/pp.jpg'), // URL'yi kendi görselinizle değiştirin
            ),
            SizedBox(height: 10),
            Text(
              '${userName}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.phone),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.email),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.location_on),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
      ); // Burada bir widget döndürmelisiniz.
  }
}