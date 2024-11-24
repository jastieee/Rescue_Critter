import 'package:flutter/material.dart';
import 'package:rescrit/const.dart'; // Assuming this contains the `bgcolor` definition.

class Control extends StatefulWidget {
  const Control({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {
  // Add a state variable for the thermal switch
  bool isThermalOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Control Screen', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/icons/home.png'), // Home icon
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
          Container(color: bgcolor), // Background color
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                'assets/icons/bg.png', // Background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Camera view container
          Positioned.fill(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
              child: const Center(
                child: Text("Camera Tile"), // Placeholder for the camera widget
              ),
            ),
          ),
          // Beacon Button at the top-left
          Positioned(
            top: 2,
            left: 30,
            child: GestureDetector(
              onTap: () {
                // Show the dialog with the release beacon image
                _showReleaseBeaconDialog(context);
              },
              child: Image.asset(
                'assets/icons/beacon_button.png',
                width: 100,
                height: 100,
              ),
            ),
          ),
          // Thermal switch with embedded on/off toggle
          Positioned(
            top: 20, // Adjusted to the top
            right: 20, // Adjusted to the right
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Thermal', // Label above the image
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center, // Align switch over the image
                      children: [
                        Image.asset(
                          'assets/icons/thermal_switch.png', // Thermal PNG
                          width: 150, // Adjusted size
                          height: 150,
                        ),
                        Transform.scale(
                          scale: 1.5, // Resize the switch
                          child: Switch(
                            value: isThermalOn,
                            onChanged: (bool value) {
                              setState(() {
                                isThermalOn = value; // Update the switch state
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      isThermalOn ? 'On' : 'Off', // Label below the image
                      style: TextStyle(
                        color: isThermalOn ? Colors.green : Colors.red, // Dynamic color
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 70,
            child: Column(
              children: [
                Image.asset(
                  'assets/icons/controller_bot.png',
                  width: 70,
                  height: 70,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            // Camera controller at the bottom-right
            bottom: 20,
            right: 70, // Adjusted to the right side
            child: Column(
              children: [
                Image.asset(
                  'assets/icons/controller_cam.png',
                  width: 70, // Increased size
                  height: 70,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Method to show the dialog with the release beacon image
  void _showReleaseBeaconDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/icons/release_beacon.png', // Image to display in the dialog
                  width: 200, // Adjust size as needed
                  height: 200, // Adjust size as needed
                ),
              ),
             Positioned(
              top: 10,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2), // Transparent white with 20% opacity
                  borderRadius: BorderRadius.circular(8), // Optional: Rounded corners for the box
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ),
            )
            ],
          ),
        );
      },
    );
  }
}
