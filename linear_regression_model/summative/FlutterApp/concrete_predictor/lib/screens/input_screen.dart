// screens/input_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InputScreen extends StatefulWidget {
  final void Function(Map<String, dynamic>)? onPrediction;

  const InputScreen({super.key, this.onPrediction});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();

  // ALL original controllers — kept exactly as you had them
  final cementController = TextEditingController(text: "350");
  final waterController = TextEditingController(text: "180");
  final superplasticizerController = TextEditingController(text: "130");
  final coarseController = TextEditingController(text: "180");
  final fineController = TextEditingController(text: "800");
  final ageController = TextEditingController(text: "28");
  final co2Controller = TextEditingController(text: "220");
  final energyController = TextEditingController(text: "325");
  final resourceController = TextEditingController(text: "170");

  double? predictedStrength;
  bool isLoading = false;

  @override
  void dispose() {
    cementController.dispose();
    waterController.dispose();
    superplasticizerController.dispose();
    coarseController.dispose();
    fineController.dispose();
    ageController.dispose();
    co2Controller.dispose();
    energyController.dispose();
    resourceController.dispose();
    super.dispose();
  }

  Future<void> _predictStrength() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final Map<String, dynamic> input = {
      "cement": double.parse(cementController.text),
      "water": double.parse(waterController.text),
      "superplasticizer": double.parse(superplasticizerController.text),
      "coarse_aggregate": double.parse(coarseController.text),
      "fine_aggregate": double.parse(fineController.text),
      "age": int.parse(ageController.text),
      "embodied_CO2": double.parse(co2Controller.text),
      "energy_consumption": double.parse(energyController.text),
      "resource_consumption": double.parse(resourceController.text),
    };

    try {
      final response = await http.post(
        Uri.parse('https://regression-analysis.onrender.com/predict'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(input),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          predictedStrength = (data["predicted_compressive_strength"] is int)
              ? (data["predicted_compressive_strength"] as int).toDouble()
              : data["predicted_compressive_strength"];
        });

        // Save full record to history
        widget.onPrediction?.call({
          "date": DateTime.now(),
          "inputs": Map<String, dynamic>.from(input),
          "strength": predictedStrength,
          "sustainability": {
            "co2": input["embodied_CO2"],
            "energy": input["energy_consumption"],
            "resource": input["resource_consumption"],
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Prediction failed. Try again.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Network error: $e")),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Widget _inputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        validator: (v) => v!.isEmpty ? 'Required' : null,
        style: GoogleFonts.inter(fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final green = const Color(0xFF1A5D1A);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      appBar: AppBar(
        backgroundColor: green,
        title: Text('Concrete Strength Predictor', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    // All 9 input fields — exactly as you wanted
                    _inputField('Cement (kg/m³)', cementController),
                    _inputField('Water (kg/m³)', waterController),
                    _inputField('Superplasticizer (kg/m³)', superplasticizerController),
                    _inputField('Coarse Aggregate (kg/m³)', coarseController),
                    _inputField('Fine Aggregate (kg/m³)', fineController),
                    _inputField('Age (days)', ageController),
                    _inputField('Embodied CO₂ (kg)', co2Controller),
                    _inputField('Energy Consumption (MJ)', energyController),
                    _inputField('Resource Consumption (kg)', resourceController),

                    const SizedBox(height: 24),

                    // Predict Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _predictStrength,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: green,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 6,
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text('PREDICT STRENGTH', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // RESULT CARD
                    if (predictedStrength != null) ...[
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        child: Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [green.withOpacity(0.95), green]),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            children: [
                              Text('PREDICTED COMPRESSIVE STRENGTH',
                                  style: GoogleFonts.inter(fontSize: 16, color: Colors.white70)),
                              const SizedBox(height: 12),
                              Text('${predictedStrength!.toStringAsFixed(1)} MPa',
                                  style: GoogleFonts.inter(fontSize: 52, fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                      Text('SUSTAINABILITY METRICS', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),

                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: _metricCard('CO₂', '${co2Controller.text} kg', Icons.recycling, Colors.redAccent)),
                          const SizedBox(width: 12),
                          Expanded(child: _metricCard('Energy', '${energyController.text} MJ', Icons.bolt, Colors.amber)),
                          const SizedBox(width: 12),
                          Expanded(child: _metricCard('Resource', '${resourceController.text} kg', Icons.terrain, Colors.brown)),
                        ],
                      ),

                      const SizedBox(height: 24),
                      OutlinedButton.icon(
                        onPressed: _predictStrength,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Make Another Prediction'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: green,
                          side: BorderSide(color: green, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _metricCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 8),
            Text(title, style: GoogleFonts.inter(fontSize: 15, color: Colors.black54)),
            const SizedBox(height: 4),
            Text(value, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}