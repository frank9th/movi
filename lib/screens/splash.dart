import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to main app after 2 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Adjust background color if needed
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpeg'), // Replace with your asset path
            fit: BoxFit.cover, // Fill the entire screen
          ),
        ),
        child: const Center(
          child: Column(
            // Use Column for vertical layout
            mainAxisAlignment: MainAxisAlignment.center, // Center elements vertically
            children: [
              Text(
                'Movit',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Adjust text color if needed
                ),
              ),
              SizedBox(height: 16.0), // Add spacing between title and tagline
              Text(
                '...Your Movie Companion..', // Replace with your tagline
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white54, // Adjust tagline color if needed
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
