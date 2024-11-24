import 'package:flutter/material.dart';
import 'package:rescrit/const.dart';
import 'package:rescrit/splash.dart';
import 'package:rescrit/control.dart';
import 'package:rescrit/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rescue Critter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
         '/': (context) => const SplashScreen(),
         '/home': (context) => const HomeScreen(),
         '/control': (context) => const Control(),
         '/data': (context) => const Data(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Home', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/icons/home.png'), // Replace menu icon with home icon
          onPressed: () {
            Navigator.of(context).pushNamed('/home'); // Navigate to home when tapped
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
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildIconTile('assets/icons/icon1.png', bgcolor),
                const SizedBox(width: 10), // Spacing between the icons
                buildIconTile('assets/icons/icon3.png', bgcolor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIconTile(String iconPath, Color bgColor) {
    return GestureDetector(
      onTap: () {
        if (iconPath == 'assets/icons/icon1.png') {
          Navigator.of(context).pushNamed('/control');
        } else if (iconPath == 'assets/icons/icon3.png') {
        Navigator.of(context).pushNamed('/data'); // Navigate to the data screen
        }
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Image.asset(iconPath, width: 180, height: 170),
        ),
      ),
    );
  }
}
