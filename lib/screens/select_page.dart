import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipezone/domains/location_manager.dart';
import 'package:swipezone/repositories/models/location.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectPage extends StatefulWidget {
  final String title;

  const SelectPage({super.key, required this.title});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  Map<Location, bool> plans = {};

  @override
  void initState() {
    super.initState();
    _loadPlans();
  }

  Future<void> _loadPlans() async {
    Map<Location, bool> fetchedPlans = LocationManager().filters;
    setState(() {
      plans = fetchedPlans;
    });
  }

  Future<void> _sharePlansViaSMS() async {
    List<String> selectedLocations = plans.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key.nom)
        .toList();

    if (selectedLocations.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No locations selected')),
      );
      return;
    }

    String message = 'Je partage avec toi mes lieux favoris : ${selectedLocations.join(", ")}';
    // Encode the message to replace spaces with %20 instead of +
    String encodedMessage = Uri.encodeComponent(message);
    Uri smsUri = Uri.parse('sms:?body=$encodedMessage');

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to open SMS app')),
        );
      }
    }
  }

  Widget _buildShareButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _sharePlansViaSMS,
        icon: const Icon(Icons.share),
        label: const Text("Share via SMS"),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _sharePlansViaSMS,
            tooltip: 'Share via SMS',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: plans.length,
              itemBuilder: (context, index) {
                bool isCheck = plans.values.elementAt(index);
                return ListTile(
                  title: Text(plans.keys.elementAt(index).nom),
                  trailing: Checkbox(
                    value: isCheck,
                    onChanged: (val) {
                      setState(() {
                        isCheck = !isCheck;
                        plans[plans.keys.elementAt(index)] = isCheck;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildShareButton(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).push('/planningpage');
        },
        tooltip: 'Add plan',
        child: const Icon(Icons.add),
      ),
    );
  }
}

