
// ignore_for_file: prefer_const_constructors, use_super_parameters

import 'dart:ui';
import 'package:event_finder/model/events_model.dart';
import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard(
    this.event, {
    Key? key,
  }) : super(key: key);

  get whiteColor => Colors.white; // Menentukan warna putih jika diperlukan.

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail event
        Navigator.pushNamed(context, RoutesName.detailEvent, arguments: event);
      },
      child: Container(
        width: 200,
        height: 262,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(right: 18),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 176,
                  height: 106,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(event.image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: SizedBox(
                    height: 34,
                    width: 34,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 18,
                          sigmaY: 18,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: whiteColor.withOpacity(0.2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                event.date!.day.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                event.date!.month.toString(),
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image.asset(
                  'lib/res/assets/ic_location.png',
                  width: 12,
                  height: 24,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  event.location!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,  // Sesuaikan dengan warna yang digunakan di _buildTrendingEventCard
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              event.title!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,  // Sesuaikan dengan warna yang digunakan di _buildTrendingEventCard
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 33,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Join',
                  style: TextStyle(
                    color: Colors.white,  // Sesuaikan dengan warna teks tombol pada _buildTrendingEventCard
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}