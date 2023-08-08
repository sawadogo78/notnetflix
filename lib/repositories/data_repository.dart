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

  // Getters

  List<Movie> get popularMovieList => _popularMovieList;

  List<Movie> get nowPlaying => _nowPlaying;

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

  Future<void> initData() async {
    await getPopularMovies();
    await getNowPlaying();
  }
}
