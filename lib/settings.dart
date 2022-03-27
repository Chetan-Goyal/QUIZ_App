import 'package:flutter/material.dart';
import 'package:quizoy/Loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isInitialised = false;

  SharedPreferences prefs;
  bool isDarkTheme = false;
  bool isUploadDisabled = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((_prefs) async {
      prefs = _prefs;
      try {
        isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
        isUploadDisabled = prefs.getBool('isUploadDisabled') ?? false;
      } catch (e) {
        isDarkTheme = false;
        prefs.setBool('isDarkTheme', isDarkTheme);
        isUploadDisabled = false;
      } finally {
        isInitialised = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          setState(() {});
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QUIZ APP',
          style: TextStyle(fontFamily: 'MetalMania'),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 114, 112, 112),
      body: SafeArea(
        child: !isInitialised
            ? Center(
                child: ColorLoader(
                    colors: Colors.primaries, duration: Duration(seconds: 5)),
              )
            : Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.color_lens, color: Colors.white),
                    title: Text(
                      'Toggle Theme',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Switch.adaptive(
                      activeColor: Theme.of(context).primaryColor,
                      value: isDarkTheme,
                      onChanged: (value) async {
                        print(value);

                        prefs.setBool('isDarkTheme', value);
                        setState(() {
                          isDarkTheme = value;
                        });
                        // if (value) {
                        //   appModel.setDarkTheme();
                        // } else {
                        //   appModel.setLightTheme();
                        // }
                      },
                    ),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.privacy_tip_outlined, color: Colors.white),
                    title: Text(
                      (isUploadDisabled ? 'Enable' : 'Disable') +
                          ' Uploading Results',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      prefs.setBool('isUploadDisabled', !isUploadDisabled);
                      setState(() {
                        isUploadDisabled = !isUploadDisabled;
                      });
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
