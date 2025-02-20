import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'theme_provider.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keegan Mboya | Tech & Design'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        color: themeProvider.isDarkMode ? Colors.black : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/me.png'),
            ),
            const SizedBox(height: 20),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color:
                    themeProvider.isDarkMode
                        ? Colors.white
                        : Colors.black, // Dynamic color
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText('Keegan Mboya'),
                  TypewriterAnimatedText(
                    'Security Analyst | Flutter Developer | Streamer',
                  ),
                  TypewriterAnimatedText('Poster Designer | Canva Enthusiast'),
                ],
                repeatForever: true,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                _socialButton(context, 'GitHub', 'https://github.com/KEEGANTE'),
                _socialButton(
                  context,
                  'LinkedIn',
                  'https://www.linkedin.com/in/keegan-mboya-024337294/',
                ),
                _socialButton(
                  context,
                  'YouTube',
                  'https://www.youtube.com/@keegan7086',
                ),
                _socialButton(
                  context,
                  'Instagram',
                  'https://www.instagram.com/its_keegan_btw/',
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'My Canva Work',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                _socialButton(
                  context,
                  'Poster 1',
                  'https://www.canva.com/design/DAGT24noExw/GQykZryh0WmT6v-hU6ZBOQ/edit?utm_content=DAGT24noExw&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton',
                ),
                _socialButton(
                  context,
                  'Poster 2',
                  'https://www.canva.com/design/DAGeK7Flycw/nnE2v7ixYRE3c39Ffo-0ew/edit?utm_content=DAGeK7Flycw&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _socialButton(BuildContext context, String label, String url) {
    return ElevatedButton(
      onPressed: () async {
        Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          if (!context.mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: Text(label),
    );
  }
}
