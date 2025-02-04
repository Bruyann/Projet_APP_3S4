import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipezone/domains/location_manager.dart';
import 'package:swipezone/domains/locations_usecase.dart';
import 'package:swipezone/screens/widgets/location_card.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: FutureBuilder(
          future: LocationUseCase().getLocation(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            var data = snapshot.data;
            if (data == null || data.isEmpty) {
              return const Center(child: Text("No locations available"));
            }

            LocationManager().locations = data;

            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: AspectRatio(
                                  aspectRatio: 3 / 4,
                                  child: LocationCard(
                                    location: data[LocationManager().currentIndex],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildActionButtons(),
                            const SizedBox(height: 16),
                            _buildLikedButton(context),
                            const SizedBox(height: 8),
                            _buildNfcButton(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add plan functionality coming soon!')),
          );
        },
        tooltip: 'Add plan',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            onPressed: () => setState(() => LocationManager().Idontwant()),
            icon: Icons.close,
            label: "Nope",
            color: Colors.red,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionButton(
            onPressed: () {
              setState(() {
                LocationManager().Iwant();
                var currentLocation = LocationManager().locations[LocationManager().currentIndex - 1];
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Lieu ajouté aux favoris : ${currentLocation.nom}\nAdresse : ${currentLocation.localization.adress ?? "Adresse non disponible"}'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              });
            },
            icon: Icons.check,
            label: "Yep",
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: color,
        backgroundColor: color.withOpacity(0.1),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  Widget _buildLikedButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => GoRouter.of(context).go('/selectpage'),
        icon: const Icon(Icons.favorite),
        label: const Text("Liked"),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildNfcButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('NFC functionality coming soon!')),
          );
        },
        icon: const Icon(Icons.nfc),
        label: const Text("Manage NFC"),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}

