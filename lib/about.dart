import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QUIZ APP',
          style: TextStyle(fontFamily: 'MetalMania'),
        ),
      ),
      backgroundColor: Colors.purple[300],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/images/dev_pic.jpeg')),
            Text(
              'Chetan Goyal',
              style: TextStyle(
                  fontFamily: 'MetalMania',
                  color: Colors.yellow[700],
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Flutter Developer',
              style: TextStyle(
                  letterSpacing: 2.5,
                  color: Colors.blue[300],
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
              width: 150,
              child: Divider(
                color: Colors.yellow[700],
              ),
            ),
            InkWell(
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ListTile(
                    leading: Icon(
                      Icons.web_asset,
                      color: Colors.blue[500],
                    ),
                    title: Center(
                      child: Text(
                        'Linkedin',
                        style: TextStyle(
                          color: Colors.yellow[800],
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () => launch('https://www.linkedin.com/in/chetan--/')),
            InkWell(
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 25),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.blue[500],
                    ),
                    title: Text(
                      'harshrock616@gmail.com',
                      style: TextStyle(
                        color: Colors.yellow[800],
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                onTap: () => launch('mailto:harshrock616@gmail.com')),
          ],
        ),
      ),
    );
  }
}
