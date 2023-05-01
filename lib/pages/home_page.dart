import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _ledState = 'KAPALI'; // Başlangıçta LED'in durumu kapalı olarak ayarlanır

  void _toggleLED(String newState) async {
    // LED durumunu değiştirme işlevi
    var response =
    await http.get(Uri.parse('http://192.168.1.118/$newState')); // ESP8266'nın IP adresi ve yeni durum bilgisi
    if (response.statusCode == 200) {
      setState(() {
        _ledState = newState == 'LED-ACIK' ? 'ACIK' : 'KAPALI'; // Yeni LED durumunu kaydedin
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('LED durumu değiştirilemedi'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter LED Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'LED durumu:',
            ),
            Text(
              _ledState,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _toggleLED('LED-ACIK'),
              child: Text('LED\'i AÇ'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _toggleLED('LED-KAPALI'),
              child: Text('LED\'i KAPAT'),
            ),
          ],
        ),
      ),
    );
  }
}
