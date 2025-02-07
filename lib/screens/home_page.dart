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
      body: SafeArea(
        child: FutureBuilder<List<Location>>(
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
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        Expanded(
          child: _buildSwipeableCard(),
        ),
        _buildActionButtons(),
        _buildNavigationButtons(),
      ],
    );
  }

  Widget _buildSwipeableCard() {
    if (_locationManager.currentIndex >= _locationManager.locations.length) {
      return const Center(child: Text('No more locations'));
    }

    return Dismissible(
      key: Key(_locationManager.locations[_locationManager.currentIndex].id.toString()),
      onDismissed: (direction) {
        setState(() {
          if (direction == DismissDirection.endToStart) {
            _locationManager.Idontwant();
          } else {
            _locationManager.Iwant();
          }
        });
      },
      child: LocationCard(
        location: _locationManager.locations[_locationManager.currentIndex],
      ),
      background: Container(
        color: Colors.green,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.check, color: Colors.white, size: 40),
          ),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Icon(Icons.close, color: Colors.white, size: 40),
          ),
        ),
      ),
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

