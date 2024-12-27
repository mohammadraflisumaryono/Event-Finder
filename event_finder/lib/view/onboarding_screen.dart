import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFDAC4D0), // Background color #DAC4D0
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Center(
                child: Image.asset(
                  'lib/res/assets/images/purple.jpg',
                  width: 400, // Menentukan lebar gambar
                  height: 400, // Menentukan tinggi gambar
                  fit: BoxFit.contain, // Menjaga rasio gambar
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              child: Column(
                children: [
                  Text(
                    'Goova',
                    style: GoogleFonts.outfit(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text color for better contrast
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Connect People, Ignite Moments',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white, // White color for slogan text
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
