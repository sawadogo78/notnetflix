import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:notnetflix/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: movie.posterUrl(),
      fit: BoxFit.cover,
      errorWidget: (context, url, error) {
        return const Center(
          child: Icon(Icons.error),
        );
      },
    );
  }
}
