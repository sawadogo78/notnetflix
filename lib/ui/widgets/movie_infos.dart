import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notnetflix/models/movie.dart';

class MovieInfos extends StatelessWidget {
  final Movie movie;
  const MovieInfos({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15.0,
        ),
        Text(
          movie.name,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          "Genres: ${movie.reformateGenres()}",
          style: GoogleFonts.poppins(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                movie.realiseDate!.substring(0, 4),
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              "Recommandé à ${(movie.vote! * 10).toInt()}%",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        )
      ],
    );
  }
}
