import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class NFCPage extends StatefulWidget {
  const NFCPage({Key? key}) : super(key: key);

  @override
  _NFCPageState createState() => _NFCPageState();
}

class _NFCPageState extends State<NFCPage> {
  String _nfcStatus = 'Prêt à scanner';
  String _tagData = '';

  @override
  void initState() {
    super.initState();
    _checkNfcAvailability();
  }

  Future<void> _checkNfcAvailability() async {
    var availability = await FlutterNfcKit.nfcAvailability;
    setState(() {
      _nfcStatus = 'NFC disponibilité: $availability';
    });
  }

  Future<void> _startNfcScan() async {
    setState(() {
      _nfcStatus = 'Scan en cours...';
      _tagData = '';
    });

    try {
      var tag = await FlutterNfcKit.poll();
      setState(() {
        _nfcStatus = 'Tag détecté!';
        _tagData = 'ID: ${tag.id}\nType: ${tag.standard}\nATQA: ${tag.atqa}\nSAK: ${tag.sak}';
      });

      if (tag.standard == "ISO 14443-4 (Type A)") {
        var result = await FlutterNfcKit.transceive("00B0950000");
        setState(() {
          _tagData += '\nDonnées supplémentaires: $result';
        });
      }
    } catch (e) {
      setState(() {
        _nfcStatus = 'Erreur: $e';
      });
    } finally {
      await FlutterNfcKit.finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner NFC'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_nfcStatus),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startNfcScan,
              child: const Text('Commencer le scan NFC'),
            ),
            const SizedBox(height: 20),
            Text(_tagData),
          ],
        ),
      ),
    );
  }
}

