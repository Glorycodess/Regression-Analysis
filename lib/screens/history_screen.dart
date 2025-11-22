// screens/history_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For beautiful date formatting

class HistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> history;

  const HistoryScreen({super.key, required this.history});

  // Helper to format date like "Apr 24", "Apr 18"
  String _formatDate(DateTime date) {
    return DateFormat('MMM d').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final green = const Color(0xFF1A5D1A);

    if (history.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F7F5),
        appBar: AppBar(
          backgroundColor: green,
          title: Text('Prediction History', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.history, size: 80, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text('No predictions yet', style: GoogleFonts.inter(fontSize: 18, color: Colors.grey[600])),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      appBar: AppBar(
        backgroundColor: green,
        title: Text('Prediction History', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        centerTitle: true,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final record = history[index];
          final date = record['date'] as DateTime? ?? DateTime.now();
          final inputs = record['inputs'] as Map<String, dynamic>;
          final strength = record['strength'] as double;
          final sust = record['sustainability'] as Map<String, dynamic>;

          return Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.only(bottom: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.green[50]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row: Date + Strength
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _formatDate(date),
                            style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Text(
                          '${strength.toStringAsFixed(1)} MPa',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: green,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Mix Details
                    _detailRow('Cement', '${inputs['cement']} kg/m³', Icons.construction),
                    _detailRow('Water', '${inputs['water']} kg/m³', Icons.water_drop),
                    _detailRow('Superplasticizer', '${inputs['superplasticizer']} kg/m³', Icons.science),
                    _detailRow('Coarse Agg.', '${inputs['coarse_aggregate']} kg/m³', Icons.grid_on),
                    if (inputs['fine_aggregate'] != null)
                      _detailRow('Fine Agg.', '${inputs['fine_aggregate']} kg/m³', Icons.grid_4x4),

                    const Divider(height: 24),

                    // Sustainability Row
                    Row(
                      children: [
                        Expanded(child: _sustMetric('CO₂', '${sust['co2']} kg', Icons.recycling, Colors.redAccent)),
                        const SizedBox(width: 12),
                        Expanded(child: _sustMetric('Energy', '${sust['energy']} MJ', Icons.bolt, Colors.orange)),
                        const SizedBox(width: 12),
                        Expanded(child: _sustMetric('Resource', '${sust['resource']} kg', Icons.terrain, Colors.brown)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _detailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text('$label:', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(width: 6),
          Text(value, style: GoogleFonts.inter(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _sustMetric(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 28, color: color),
        const SizedBox(height: 4),
        Text(title, style: GoogleFonts.inter(fontSize: 13, color: Colors.black54)),
        Text(value, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}