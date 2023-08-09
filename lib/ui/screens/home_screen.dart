import 'package:flutter/material.dart';
import 'package:notnetflix/repositories/data_repository.dart';
import 'package:notnetflix/ui/widgets/movie_card.dart';
import 'package:notnetflix/ui/widgets/movie_category.dart';
import 'package:notnetflix/utils/constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: Image.asset('assets/images/netflix_logo_2.png'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 500,
            child: dataProvider.popularMovieList.isEmpty
                ? const Center()
                : MovieCard(movie: dataProvider.popularMovieList.first),
          ),
          MovieCategory(
            label: 'Tendance actuelle',
            movieList: dataProvider.popularMovieList,
            imageHeight: 160,
            imageWidth: 110,
            callback: dataProvider.getPopularMovies,
          ),
          MovieCategory(
            label: 'Actuellement au cinema',
            movieList: dataProvider.nowPlaying,
            imageHeight: 320,
            imageWidth: 220,
            callback: dataProvider.getNowPlaying,
          ),
          MovieCategory(
            label: 'Bientôt disponible',
            movieList: dataProvider.upcomingMovies,
            imageHeight: 210,
            imageWidth: 110,
            callback: dataProvider.getUpcomingMovies,
          ),
          MovieCategory(
            label: 'Animations',
            movieList: dataProvider.animationMovies,
            imageHeight: 320,
            imageWidth: 220,
            callback: dataProvider.getAnimationMovies,
          ),
        ],
      ),
    );
  }
}
