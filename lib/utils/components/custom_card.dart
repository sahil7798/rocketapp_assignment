//this class is cretaed for used custom Card Tile

import 'package:flutter/material.dart';
import 'package:rocketapp_assignment/model/rocket_model.dart';
import 'package:rocketapp_assignment/utils/constants.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    Key? key,
    required this.rocket,
    required this.onTap,
  }) : super(key: key);

  final RocketModel rocket;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(rocket.flickrImages.first),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rocket.name,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Country: ${rocket.country.toString()}",
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black54),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Engine: ${rocket.engines.number.toString()}",
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black54),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
