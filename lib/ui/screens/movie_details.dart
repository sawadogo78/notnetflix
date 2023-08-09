// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/repositories/data_repository.dart';
import 'package:notnetflix/utils/constants.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailsPage({super.key, required this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Movie? newMovie;

  @override
  void initState() {
    super.initState();
    getMovieData();
  }

  void getMovieData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    // Get Movie details
    Movie _movie = await dataProvider.getMovieDetails(movie: widget.movie);
    setState(() {
      newMovie = _movie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
      ),
      body: newMovie == null
          ? Center(
              child: SpinKitFadingCircle(
                size: 40,
                color: kPrimaryColor,
              ),
            )
          : ListView(
              children: [
                Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.red,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(newMovie!.title)
              ],
            ),
    );
  }
}
