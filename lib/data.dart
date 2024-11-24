import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Import fl_chart package
import 'package:rescrit/const.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  // State variable to track the selected data type (Humidity or Temperature)
  bool isHumiditySelected = true; // Start with Humidity selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Data', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/icons/home.png'), // Use home icon instead of menu
          onPressed: () {
            Navigator.of(context).pushNamed('/home'); // Navigate to Home screen
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/set1.png', color: Colors.black),
            onPressed: () {
              // Implement settings action
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: bgcolor,
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                'assets/icons/bg.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0), // Add padding for layout
            child: Row(
              children: [
                // Left column for icons (Humidity and Temperature)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isHumiditySelected = true; // Switch to Humidity view
                        });
                      },
                      child: buildIconTile('assets/icons/humidity.png'),
                    ),
                    const SizedBox(height: 20), // Space between icons
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isHumiditySelected = false; // Switch to Temperature view
                        });
                      },
                      child: buildIconTile('assets/icons/temperature.png'),
                    ),
                  ],
                ),
                
                const SizedBox(width: 20), // Space between icons and the data box

                // Right side box for graph (transparent)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Make the background transparent
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display the title (Temperature or Humidity)
                        Text(
                          isHumiditySelected ? 'Humidity' : 'Temperature',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,  // Set the color to white
                          ),
                        ),

                        const SizedBox(height: 10), // Space between title and content

                        // Display graph based on selection (Humidity or Temperature)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: !isHumiditySelected
                                ? LineChart(
                                    LineChartData(
                                      gridData: const FlGridData(show: true),
                                      titlesData: const FlTitlesData(
                                        leftTitles: AxisTitles(
                                          sideTitles: SideTitles(showTitles: true),
                                        ),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(showTitles: true),
                                        ),
                                        topTitles: AxisTitles(
                                          sideTitles: SideTitles(showTitles: false),
                                        ),
                                        rightTitles: AxisTitles(
                                          sideTitles: SideTitles(showTitles: false),
                                        ),
                                      ),
                                      borderData: FlBorderData(show: true),
                                      lineBarsData: [
                                        LineChartBarData(
                                          spots: [
                                            const FlSpot(0, 20), // Starting at 20°C
                                            const FlSpot(1, 30),  // Higher spike at point 1
                                            const FlSpot(2, 15),  // Drop back to baseline
                                            const FlSpot(3, 25),  // Moderate spike
                                            const FlSpot(4, 22),  // Slight drop
                                            const FlSpot(5, 28),  // Another spike
                                          ],
                                          isCurved: true,
                                          color: Colors.orange, // Use a color for temperature (e.g., orange)
                                          barWidth: 3,
                                          belowBarData: BarAreaData(show: true, color: Colors.orange.withOpacity(0.3)),
                                        ),
                                      ],
                                    ),
                                  )
                                : LineChart(
                                    LineChartData(
                                      gridData: const FlGridData(show: true),
                                      titlesData: const FlTitlesData(
                                        leftTitles: AxisTitles(
                                          sideTitles: SideTitles(showTitles: true),
                                        ),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(showTitles: true),
                                        ),
                                        topTitles: AxisTitles(
                                          sideTitles: SideTitles(showTitles: false),
                                        ),
                                        rightTitles: AxisTitles(
                                          sideTitles: SideTitles(showTitles: false),
                                        ),
                                      ),
                                      borderData: FlBorderData(show: true),
                                      lineBarsData: [
                                        LineChartBarData(
                                          spots: [
                                            const FlSpot(0, 0), // Starting point for humidity (e.g., 0%)
                                            const FlSpot(1, 5),  // Humidity spike
                                            const FlSpot(2, 0),  // Back to baseline
                                            const FlSpot(3, 3),  // Slight increase
                                            const FlSpot(4, 4),  // Higher spike
                                            const FlSpot(5, 0),  // Back to baseline
                                          ],
                                          isCurved: true,
                                          color: Colors.purple, // Use purple for humidity
                                          barWidth: 3,
                                          belowBarData: BarAreaData(show: true, color: Colors.purple.withOpacity(0.3)),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to create the icons
  Widget buildIconTile(String iconPath) {
    return Image.asset(
      iconPath,
      width: 50,
      height: 50,
    );
  }
}
