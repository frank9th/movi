import 'package:flutter/material.dart';
import 'package:movi/screens/models.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              child: Image.asset(
                'assets/logo.jpeg',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Movit',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Your Movie Companion..', // Replace with your tagline
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey, // Adjust tagline color if needed
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background image with resize and fade effect
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.0), // Transparent black at top
                  Colors.black.withOpacity(0.8), // Semi-transparent black at bottom
                ],
              ),
            ),
            child: Image.network(
              'https://image.tmdb.org/t/p/original${movie.posterPath}',
              fit: BoxFit.cover, // Cover the entire area
            ),
          ),
          // Content with bottom positioning and shadow (optional)
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                // color: Colors.black45.withOpacity(0.6),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.0), // Transparent black at top
                    Colors.black.withOpacity(0.8),
                    Colors.black, // Semi-transparent black at bottom
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: const Offset(0, -5), // Shadow slightly upwards (optional)
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie title
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Overview and other details
                  const SizedBox(height: 16.0),
                  Text(
                    movie.overview,
                    // style: TextStyle(fontSize: 13.0),
                  ),
                  // ... other details (release date, etc.)

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Movie title

                      Row(
                        // Row for average rating and release date
                        children: [
                          // Average rating with icon (optional)
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            '${movie.voteAverage}', // Replace with actual rating property
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const Spacer(),
                          // Release date
                          Text(
                            'Release Date: ${movie.releaseDate}', // Replace with actual date property
                            style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      // Watch now button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle watch now action (e.g., navigate to video player)
                            print('Watch Now button pressed!');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple,
                            onPrimary: Colors.white,
                          ),
                          child: const Text('Watch Now'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
