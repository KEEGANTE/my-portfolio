import 'package:flutter/material.dart';
import 'package:my_portfolio/portfolio_page.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData,
      home: const PortfolioPage(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("My Portfolio")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            themeProvider.toggleTheme();
          },
          child: const Text("Toggle Theme"),
        ),
      ),
    );
  }
}
