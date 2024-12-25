import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:event_finder/res/theme.dart'; // Import your AppTheme

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.lightTheme; // Access the custom theme

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back, color: theme.iconTheme.color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        middle: Text("Event Details", style: theme.appBarTheme.titleTextStyle),
        border: null,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Image with Overlay
              Stack(
                children: [
                  Image.network(
                    "https://images.unsplash.com/photo-1587502536263-92963ecadcf0", // Placeholder URL
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 20,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Coldplay : Music of the Spheres",
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(CupertinoIcons.location, size: 16, color: theme.iconTheme.color),
                              const SizedBox(width: 4),
                              Text(
                                "Gelora Bung Karno Stadium, Jakarta",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(CupertinoIcons.calendar, size: 16, color: theme.iconTheme.color),
                              const SizedBox(width: 4),
                              Text("November 15 2023", style: theme.textTheme.bodyMedium),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(CupertinoIcons.person_2, size: 16, color: theme.iconTheme.color),
                              const SizedBox(width: 4),
                              Text(
                                "50K+ Participants",
                                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Integer id augue iaculis, iaculis orci ut, blandit quam. Donec in elit auctor, finibus quam in, pharetra velit. Proin id ligula dictum, covalis enim ut, facilisis massa. Mauris a nisi ut sapien blandit imperdiet.",
                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Text(
                        "Read More..",
                        style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.secondary),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Venue & Location Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Venue & Location",
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "https://maps.googleapis.com/maps/api/staticmap?center=San+Francisco&zoom=13&size=600x300&key=YOUR_API_KEY", // Placeholder Map
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Price and Buy Button Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start from",
                          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                        ),
                        Text(
                          "IDR 1.100.000",
                          style: theme.textTheme.titleLarge,
                        ),
                      ],
                    ),
                    CupertinoButton.filled(
                      child: const Text("Buy Ticket"),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}