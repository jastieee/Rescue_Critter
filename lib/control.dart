import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:rescrit/const.dart'; // Assuming this contains the bgcolor definition.

class Control extends StatefulWidget {
  const Control({super.key});

  @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {
  String? _activeButton; // Tracks the currently active button for shadows

  // Handle joystick and camera button actions
  void _handleJoystickAction(String action) {
    setState(() {
      _activeButton = action;
    });

    print('Action triggered: $action');
    
    // Send HTTP request to ESP8266 based on the action
    _sendActionToESP(action);
  }

  void _stopAction() {
    setState(() {
      _activeButton = null;
    });
    print('Stop action triggered');
    // Send stop action to ESP8266
    _sendActionToESP('stop');
  }

  Future<void> _sendActionToESP(String action) async {
    String url = 'http://192.168.226.47/control?action=$action'; // Add the action parameter

    try {
      // Send HTTP GET request to the ESP8266
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) { 
        // Successfully triggered the action
        print('ESP8266 Response: ${response.body}');
      } else {
        // Handle error if the request fails
        print('Failed to send action: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending action to ESP8266: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background color
        Container(color: bgcolor),

        // Background image
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              'assets/icons/bg.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Joystick on the left side
        Positioned(
          left: 80,
          bottom: 60,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTapDown: (_) => _handleJoystickAction('up'),
                onTapUp: (_) => _stopAction(),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: _activeButton == 'up'
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ]
                        : [],
                  ),
                  child: Image.asset(
                    'assets/icons/up-move-icon.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
              const SizedBox(height: 0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTapDown: (_) => _handleJoystickAction('left'),
                    onTapUp: (_) => _stopAction(),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: _activeButton == 'left'
                            ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: const Offset(-5, 0),
                                ),
                              ]
                            : [],
                      ),
                      child: Image.asset(
                        'assets/icons/left-move-icon.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTapDown: (_) => _handleJoystickAction('right'),
                    onTapUp: (_) => _stopAction(),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: _activeButton == 'right'
                            ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: const Offset(5, 0),
                                  
                                ),
                              ]
                            : [],
                      ),
                      child: Image.asset(
                        'assets/icons/right-move-icon.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 0),
              GestureDetector(
                onTapDown: (_) => _handleJoystickAction('down'),
                onTapUp: (_) => _stopAction(),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: _activeButton == 'down'
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(0, -5),
                            ),
                          ]
                        : [],
                  ),
                  child: Image.asset(
                    'assets/icons/down-move-icon.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Left and Right camera buttons
        Positioned(
          right: 80,
          bottom: 135,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTapDown: (_) => _handleJoystickAction('left-camera'),  // Trigger left-camera action on press
                onTapUp: (_) => _stopAction(),  // Stop action when released
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: _activeButton == 'left-camera'
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ]
                        : [],
                  ),
                  child: Image.asset(
                    'assets/icons/left-camera-icon.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
              const SizedBox(width: 30),
              GestureDetector(
                onTapDown: (_) => _handleJoystickAction('right-camera'),  // Trigger right-camera action on press
                onTapUp: (_) => _stopAction(),  // Stop action when released
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: _activeButton == 'right-camera'
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ]
                        : [],
                  ),
                  child: Image.asset(
                    'assets/icons/right-camera-icon.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
            ],
          ),
        ),

       // Home button on top of all layers
        Positioned(
          top: 20, // Adjust as needed
          left: 20, // Adjust as needed
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/home');
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7), // Semi-transparent background color for the box
                borderRadius: BorderRadius.circular(10), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8), // Padding inside the box
              child: Image.asset(
                'assets/icons/home.png',
                width: 40,
                height: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}