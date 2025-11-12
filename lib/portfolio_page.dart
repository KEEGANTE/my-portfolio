// portfolio_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_provider.dart';

// --------------------- PORTFOLIO PAGE ---------------------
class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final scrollController = ScrollController();

    // Section keys
    final heroKey = GlobalKey();
    final skillsKey = GlobalKey();
    final portfolioKey = GlobalKey();
    final contactKey = GlobalKey();

    void scrollToSection(GlobalKey key) {
      final context = key.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Keegan Mboya',
          style: GoogleFonts.jetBrainsMono(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        actions: [
          _NavItem('About', () => scrollToSection(heroKey)),
          _NavItem('Skills', () => scrollToSection(skillsKey)),
          _NavItem('Work', () => scrollToSection(portfolioKey)),
          _NavItem('Contact', () => scrollToSection(contactKey)),
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _HeroSection(key: heroKey),
            _SkillsSection(key: skillsKey),
            _PortfolioSection(key: portfolioKey),
            _ContactSection(key: contactKey),
            const SizedBox(height: 50),
            _Footer(),
          ],
        ),
      ),
    );
  }
}

// --------------------- NAV ITEM ---------------------
class _NavItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _NavItem(this.label, this.onTap);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
          fontSize: 16,
        ),
      ),
    );
  }
}

// --------------------- HERO SECTION ---------------------
class _HeroSection extends StatelessWidget {
  const _HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme.onBackground;

    return Container(
      height: size.height,
      width: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.5), width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.5),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 85,
                backgroundImage: AssetImage('assets/me.png'),
              ),
            ).animate().scale(duration: 900.ms, curve: Curves.easeOut).fadeIn(),

            const SizedBox(height: 32),

            // Name
            DefaultTextStyle(
              style: GoogleFonts.jetBrainsMono(
                fontSize: 44,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              child: AnimatedTextKit(
                animatedTexts: [TypewriterAnimatedText('Keegan Mboya')],
                isRepeatingAnimation: false,
              ),
            ),

            const SizedBox(height: 16),

            // Tagline
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Security Analyst • Flutter Dev • Designer',
                  speed: const Duration(milliseconds: 70),
                ),
              ],
              isRepeatingAnimation: false,
            ).animate(delay: 1400.ms).fadeIn().slideY(begin: 0.4, end: 0),

            const SizedBox(height: 40),

            // Social icons with names
            Wrap(
              spacing: 30,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _IconWithLabel(
                  icon: Icons.code,
                  label: 'GitHub',
                  url: 'https://github.com/KEEGANTE',
                ),
                _IconWithLabel(
                  icon: Icons.work,
                  label: 'LinkedIn',
                  url: 'https://www.linkedin.com/in/keegan-mboya-024337294/',
                ),
                _IconWithLabel(
                  icon: Icons.play_circle,
                  label: 'YouTube',
                  url: 'https://www.youtube.com/@keegan7086',
                ),
                _IconWithLabel(
                  icon: Icons.camera_alt,
                  label: 'Instagram',
                  url: 'https://www.instagram.com/its_keegan_btw/',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------- ICON WITH LABEL ---------------------
class _IconWithLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;
  const _IconWithLabel({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onBackground;
    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).cardColor.withOpacity(0.15),
              border: Border.all(color: color.withOpacity(0.5), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// --------------------- SKILLS SECTION ---------------------
class _SkillsSection extends StatelessWidget {
  const _SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onBackground;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'Skills & Superpowers',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 25,
            runSpacing: 25,
            alignment: WrapAlignment.center,
            children: [
              _SkillBubble('Flutter', Icons.phone_android, Colors.blue),
              _SkillBubble('Dart', Icons.code, Colors.blue),
              _SkillBubble('CyberSec', Icons.security, Colors.red),
              _SkillBubble('UI/UX', Icons.palette, Colors.orange),
              _SkillBubble('Canva', Icons.design_services, Colors.purple),
              _SkillBubble('Git', Icons.gite, Colors.black),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkillBubble extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _SkillBubble(this.label, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    final colorText = Theme.of(context).colorScheme.onBackground;
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorText.withOpacity(0.5), width: 1),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: color),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: colorText,
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------- PORTFOLIO SECTION ---------------------
class _PortfolioSection extends StatelessWidget {
  const _PortfolioSection({super.key});

  @override
  Widget build(BuildContext context) {
    final posters = [
      {
        'title': 'Tech Conference Poster',
        'url': 'https://www.canva.com/design/DAGT24noExw/',
        'image': '/assets/Resting Temptation.png',
      },
      {
        'title': 'Cybersecurity Awareness',
        'url': 'https://www.canva.com/design/DAGeK7Flycw/',
        'image': '/assets/The Plan Of Redemption.png',
      },
    ];

    final color = Theme.of(context).colorScheme.onBackground;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: Column(
        children: [
          Text(
            'Canva Creations',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: posters.map((p) => _PosterCard(p)).toList(),
          ),
        ],
      ),
    );
  }
}

class _PosterCard extends StatelessWidget {
  final Map<String, String> poster;
  const _PosterCard(this.poster);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(poster['url']!)),
      child: Container(
        width: 300,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
          image: DecorationImage(
            image: AssetImage(poster['image']!), // ✅ AssetImage
            fit: BoxFit.cover,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              poster['title']!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --------------------- CONTACT SECTION ---------------------
class _ContactSection extends StatelessWidget {
  const _ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onBackground;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Column(
        children: [
          Text(
            'Let’s Build Something Epic',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 24),
          const SelectableText(
            'keeganmboya@example.com',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed:
                () => launchUrl(Uri.parse('mailto:keeganmboya@example.com')),
            icon: const Icon(Icons.email),
            label: const Text('Say Hello'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------- FOOTER ---------------------
class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onBackground.withOpacity(0.6);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Text(
            '© 2025 Keegan Mboya',
            style: TextStyle(color: color, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            'All rights reserved.',
            style: TextStyle(color: color, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
