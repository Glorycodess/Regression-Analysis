// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart'; // ← VERY IMPORTANT: Import main.dart to access MainNavigation

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color green = const Color(0xFF1A5D1A);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      appBar: AppBar(
        backgroundColor: green,
        title: Text(
          'Concrete Strength Predictor',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: green.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.construction, size: 80, color: green),
              ),

              const SizedBox(height: 48),

              Text(
                'WELCOME',
                style: GoogleFonts.inter(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Predict concrete compressive strength\n& sustainability metrics instantly',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 17, height: 1.5, color: Colors.black54),
              ),

              const SizedBox(height: 60),

              // FIXED BUTTON — NO MORE ERRORS!
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // This works 100% — clean, safe, no private types
                    MainNavigation.navKey.currentState?.switchToPredictTab();
                  },
                  icon: const Icon(Icons.calculate, size: 28),
                  label: const Text(
                    'Start Prediction',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 8,
                    shadowColor: green.withOpacity(0.4),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Fast • Accurate • Eco-Friendly',
                style: GoogleFonts.inter(fontSize: 15, color: Colors.black45, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}