// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/services/api_service.dart';

// Data Provider
class DataRepository with ChangeNotifier {
  final APIService _apiService = APIService();
  final List<Movie> _popularMovieList = [];
  int _popularMoviePageIndex = 1;
  final List<Movie> _nowPlaying = [];
  int _nowPlayingIndex = 1;
  final List<Movie> _upcomingMovies = [];
  int _upcomingMoviesPageIndex = 1;
  final List<Movie> _animationMovies = [];
  int _animationMoviesPageIndex = 1;

  // Getters

  List<Movie> get popularMovieList => _popularMovieList;

  List<Movie> get nowPlaying => _nowPlaying;
  List<Movie> get upcomingMovies => _upcomingMovies;

  List<Movie> get animationMovies => _animationMovies;

  Future<void> getPopularMovies() async {
    try {
      List<Movie> movies = await _apiService.getPopularMovies(
          pageNumber: _popularMoviePageIndex);
      _popularMovieList.addAll(movies);
      _popularMoviePageIndex++;
      // Alwals add notifyListeners to let know that the data has changed
      notifyListeners();
    } on Response catch (response) {
      print('Error : ${response.statusCode}');
      rethrow;
      // With rethrow, the error will be shown on the screen
    }
  }

  Future<void> getNowPlaying() async {
    try {
      List<Movie> movies =
          await _apiService.getNowPlaying(pageNumber: _nowPlayingIndex);
      _nowPlaying.addAll(movies);
      _nowPlayingIndex++;
      // Alwals add notifyListeners to let know that the data has changed
      notifyListeners();
    } on Response catch (response) {
      print('Error : ${response.statusCode}');
      rethrow;
      // With rethrow, the error will be shown on the screen
    }
  }

  Future<void> getUpcomingMovies() async {
    try {
      List<Movie> movies = await _apiService.getUpcomingMovies(
          pageNumber: _upcomingMoviesPageIndex);
      _upcomingMovies.addAll(movies);
      _upcomingMoviesPageIndex++;
      // Alwals add notifyListeners to let know that the data has changed
      notifyListeners();
    } on Response catch (response) {
      print('Error : ${response.statusCode}');
      rethrow;
      // With rethrow, the error will be shown on the screen
    }
  }

  Future<void> getAnimationMovies() async {
    try {
      List<Movie> movies = await _apiService.getAnimationMovies(
          pageNumber: _animationMoviesPageIndex);
      _animationMovies.addAll(movies);
      _animationMoviesPageIndex++;
      // Alwals add notifyListeners to let know that the data has changed
      notifyListeners();
    } on Response catch (response) {
      print('Error : ${response.statusCode}');
      rethrow;
      // With rethrow, the error will be shown on the screen
    }
  }

  Future<Movie> getMovieDetails({required Movie movie}) async {
    try {
      // On remplace toutes ces 4 requêtes par la nouvelle function getMovie
      // // get movie infos
      // Movie newMovie = await _apiService.getMovieDetails(movie: movie);
      // // get movie videos
      // newMovie = await _apiService.getMovieVideos(movie: newMovie);
      // // get movie casting
      // newMovie = await _apiService.getMovieCast(movie: newMovie);
      // // get movie images
      // newMovie = await _apiService.getMovieImage(movie: newMovie);

      // get Movie, qui remplace les 4 requêtes, application performantes
      Movie newMovie = await _apiService.getMovie(movie: movie);
      return newMovie;
    } on Response catch (response) {
      print('Error : ${response.statusCode}');
      rethrow;
    }
  }

  Future<void> initData() async {
    // await getPopularMovies();
    // await getNowPlaying();
    // await getUpcomingMovies();
    // await getAnimationMovies();
    // For performance and to make the call of all those functions in parallel
    // Requête en parallèle
    await Future.wait([
      getPopularMovies(),
      getNowPlaying(),
      getUpcomingMovies(),
      getAnimationMovies(),
    ]);
  }
}
