// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/repositories/data_repository.dart';
import 'package:notnetflix/ui/widgets/action_button.dart';
import 'package:notnetflix/ui/widgets/casting_card.dart';
import 'package:notnetflix/ui/widgets/galerie_card.dart';
import 'package:notnetflix/ui/widgets/movie_infos.dart';
import 'package:notnetflix/ui/widgets/my_video_player.dart';
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
                color: kPrimaryColor,
                size: 40,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    child: newMovie!.videos!.isEmpty
                        ? Center(
                            child: Text(
                              "La vidéo n'est encore disponible",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : MyVideoPlayer(movieId: newMovie!.videos!.first),
                  ),
                  MovieInfos(movie: newMovie!),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ActionButton(
                    label: 'Lecture',
                    icon: Icons.play_arrow,
                    bgColor: Colors.white,
                    color: kBackgroundColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ActionButton(
                    label: 'Télécharger la vidéo',
                    icon: Icons.download,
                    bgColor: Colors.grey.withOpacity(0.3),
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    newMovie!.overview,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Castings',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: newMovie!.casting!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return newMovie!.casting![index].imageURL == null
                            ? const Center()
                            : CastingCard(
                                person: newMovie!.casting![index],
                              );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Galerrie',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: newMovie!.images!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GalerieCard(
                          posterPath: newMovie!.images![index],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
