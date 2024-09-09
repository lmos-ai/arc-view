import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LanguagePreferenceScreen extends StatefulWidget {
  const LanguagePreferenceScreen({super.key});

  @override
  _LanguagePreferenceScreenState createState() =>
      _LanguagePreferenceScreenState();
}

class _LanguagePreferenceScreenState extends State<LanguagePreferenceScreen> {
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    child: Text('English'),
                    onPressed: () {
                      selectedLanguage = 'English';
                      context.go('/chat', extra: selectedLanguage);
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('German'),
                    onPressed: () {
                      selectedLanguage = 'German';
                      context.go('/chat', extra: selectedLanguage);
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('French'),
                    onPressed: () {
                      selectedLanguage = 'French';
                      context.go('/chat', extra: selectedLanguage);
                    },
                  )
                ]),
          ],
        ),
      ),
    );
  }
}
