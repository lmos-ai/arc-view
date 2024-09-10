import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreferenceScreen extends StatefulWidget {
  const LanguagePreferenceScreen({super.key});

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguagePreferenceScreen> {
  String selectedLanguageName = 'English (UK)';
  String selectedLanguage = 'en';

  final List<Map<String, String>> languages = [
    {"name": "English (UK)", "flagCode": "gb", "code": 'en'},
    {"name": "French", "flagCode": "fr", "code": 'fr'},
    {"name": "German", "flagCode": "de", "code": 'de'},
    {"name": "Spanish", "flagCode": "es", "code": 'es'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Languages'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Selected Language',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListTile(
              leading: Image.asset(
                'icons/flags/png/${languages.firstWhere((lang) => lang["name"] == selectedLanguageName)["flagCode"]}.png',
                package: 'country_icons',
                width: 30,
                height: 30,
              ),
              title: Text(selectedLanguageName),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'All Languages',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: languages.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: ListTile(
                    leading: Image.asset(
                      'icons/flags/png/${languages[index]["flagCode"]}.png',
                      package: 'country_icons',
                      width: 30,
                      height: 30,
                    ),
                    title: Text(languages[index]["name"]!),
                    trailing: Radio<String>(
                      value: languages[index]["name"]!,
                      groupValue: selectedLanguageName,
                      onChanged: (String? value) {
                        setState(() {
                          selectedLanguageName = value!;
                          selectedLanguage = languages[index]["code"]!;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Handle save settings action
                _selectLanguage(context,selectedLanguage);
                context.go("/chat");
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Save Settings'),
                  SizedBox(width: 8),
                  Icon(Icons.check),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectLanguage(BuildContext context, String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', languageCode);
  }
}
