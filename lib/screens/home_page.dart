import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipezone/domains/location_manager.dart';
import 'package:swipezone/domains/locations_usecase.dart';
import 'package:swipezone/screens/widgets/location_card.dart';
import 'package:swipezone/repositories/models/location.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocationManager _locationManager = LocationManager();
  final LocationUseCase _locationUseCase = LocationUseCase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Location>>(
        future: _locationUseCase.getLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No locations available'));
          }

          _locationManager.locations = snapshot.data!;
          return _buildMainContent();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GoRouter.of(context).go('/planningpage'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        Expanded(
          child: LocationCard(
            location: _locationManager.locations[_locationManager.currentIndex],
          ),
        ),
        _buildActionButtons(),
        _buildNavigationButtons(),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _locationManager.Idontwant();
            });
          },
          child: const Text('Nope'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _locationManager.Iwant();
            });
          },
          child: const Text('Yep'),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => GoRouter.of(context).go('/selectpage'),
          child: const Text('View Liked Locations'),
        ),
        ElevatedButton(
          onPressed: () => GoRouter.of(context).go('/nfcpage'),
          child: const Text('Scanner NFC'),
        ),
      ],
    );
  }
}

