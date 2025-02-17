import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/routes/routes_name.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Memulai timer setelah widget dibangun
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamed(context, RoutesName.home);
    });

    return Scaffold(
      body: Container(
        color:
            Theme.of(context).colorScheme.surface, // Background color #DAC4D0
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Image.asset(
                'lib/res/assets/images/logogoova.png',
                width: 200, // Menentukan lebar gambar
                height: 200, // Menentukan tinggi gambar
                fit: BoxFit.contain, // Menjaga rasio gambar
              ),
            ),
            const SizedBox(
                height: 38), // Tidak lagi relevan jika tidak terkait posisi
            Positioned(
              bottom: 150,
              child: Column(
                children: [
                  Text(
                    'Goova',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color:
                          Colors.purple, // White text color for better contrast
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Connect People, Ignite Moments',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.purple, // White color for slogan text
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
