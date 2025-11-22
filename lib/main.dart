// main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/input_screen.dart';
import 'screens/history_screen.dart';

void main() {
  runApp(const ConcretePredictorApp());
}

class ConcretePredictorApp extends StatelessWidget {
  const ConcretePredictorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Concrete Strength Predictor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A5D1A)),
        scaffoldBackgroundColor: const Color(0xFFF5F7F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A5D1A),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A5D1A),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(vertical: 18),
            elevation: 6,
          ),
        ),
      ),
      home: const MainNavigation(),
    );
  }
}

// ──────────────────────────────────────────────────────────────
// MAIN NAVIGATION – PUBLIC STATE CLASS (NO UNDERSCORE!)
class MainNavigation extends StatefulWidget {
  // This key lets ANY screen switch tabs safely
  static final GlobalKey<MainNavigationState> navKey = GlobalKey<MainNavigationState>();

  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => MainNavigationState();
}

// IMPORTANT: Public class name → NO underscore!
class MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 1; // Start on Predict tab

  final List<Map<String, dynamic>> _history = [];

  void addToHistory(Map<String, dynamic> record) {
    setState(() {
      _history.insert(0, record);
    });
  }

  void switchToPredictTab() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const HomeScreen(),
          InputScreen(onPrediction: addToHistory),
          HistoryScreen(history: List.unmodifiable(_history)),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        indicatorColor: const Color(0xFF1A5D1A).withOpacity(0.15),
        backgroundColor: Colors.white,
        elevation: 8,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.calculate_outlined), selectedIcon: Icon(Icons.calculate), label: 'Predict'),
          NavigationDestination(icon: Icon(Icons.history_outlined), selectedIcon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}