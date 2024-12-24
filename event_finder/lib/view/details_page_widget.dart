import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        middle: Text("Event Details"),
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
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
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
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(CupertinoIcons.location, size: 16),
                              SizedBox(width: 4),
                              Text(
                                "Gelora Bung Karno Stadium, Jakarta",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(CupertinoIcons.calendar, size: 16),
                              SizedBox(width: 4),
                              Text("November 15 2023", style: TextStyle(fontSize: 14)),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(CupertinoIcons.person_2, size: 16),
                              SizedBox(width: 4),
                              Text(
                                "50K+ Participants",
                                style: TextStyle(fontSize: 14, color: CupertinoColors.systemGrey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Description Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Integer id augue iaculis, iaculis orci ut, blandit quam. Donec in elit auctor, finibus quam in, pharetra velit. Proin id ligula dictum, covalis enim ut, facilisis massa. Mauris a nisi ut sapien blandit imperdiet.",
                      style: TextStyle(fontSize: 14, color: CupertinoColors.systemGrey),
                    ),
                    SizedBox(height: 8),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Text(
                        "Read More..",
                        style: TextStyle(color: CupertinoColors.systemPurple),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Venue & Location Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Venue & Location",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
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
              SizedBox(height: 16),

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
                          style: TextStyle(
                            fontSize: 14,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        Text(
                          "IDR 1.100.000",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    CupertinoButton.filled(
                      child: Text("Buy Ticket"),
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