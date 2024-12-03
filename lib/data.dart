import 'dart:async'; // Import Timer
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  String loRaData = "";
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    fetchLoRaData(); // Initial fetch when screen loads
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      fetchLoRaData(); // Fetch data every 5 seconds
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Stop the timer when the screen is disposed
    super.dispose();
  }

  // Function to fetch LoRa data from the ESP8266 server
  Future<void> fetchLoRaData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.226.140/getLoRaData'));

      if (response.statusCode == 200) {
        var data = response.body;

        // Fix the malformed JSON as described earlier
        data = data.replaceAll('"temperature": "temperature":', '"temperature":');

        // Now parse the fixed JSON
        var decodedData = jsonDecode(data);

        print('Raw LoRa Packet: ${response.body}'); // Prints the raw JSON packet from LoRa

        setState(() {
          // Access the nested humidity and temperature values correctly
          double humidity = decodedData['humidity'] != null ? decodedData['humidity']['humidity']?.toDouble() : 0.0;
          double temperature = decodedData['humidity'] != null ? decodedData['humidity']['temperature']?.toDouble() : 0.0;
          loRaData = 'Humidity: $humidity, Temperature: $temperature';
        });

        print('LoRa Data: $loRaData');  // Prints the processed data
      } else {
        throw Exception('Failed to load LoRa data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Data', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/icons/home.png'),
          onPressed: () {
            Navigator.of(context).pushNamed('/home');
          },
        ),
      ),
      body: Stack(
        children: [
          Container(color: Colors.blue),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset('assets/icons/bg.png', fit: BoxFit.cover),
            ),
          ),
          Center( // Added Center widget to center the entire Column
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Vertical centering
                crossAxisAlignment: CrossAxisAlignment.center, // Horizontal centering
                children: [
                  const Text(
                    'Temperature and Humidity Data',
                    style: TextStyle(
                      fontSize: 44, // Bigger font size
                      fontWeight: FontWeight.bold, // Bold text
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    loRaData,
                    style: const TextStyle(
                      fontSize: 32, // Text size for the data itself
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center, // Center-align the data
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
