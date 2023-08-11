// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dio/dio.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/models/person.dart';
import 'package:notnetflix/services/api.dart';

class APIService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    // Let build our URL witch will be called

    String url = api.baseUrl + path;
    // Here we build paramters for the request
    Map<String, dynamic> query = {
      'api_key': api.apikey,
      'language': 'en-US',
    };
// If params is  provide, let's add it to the query to give the all parameters
    if (params != null) {
      query.addAll(params);
    }

    // Making API request call with get method using dio package

    final response = await dio.get(url, queryParameters: query);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getPopularMovies({required int pageNumber}) async {
    Response response = await getData('/movie/popular', params: {
      'page': pageNumber,
    });
    if (response.statusCode == 200) {
      Map data = response.data; // Our data output in a json format
      // List of results (just take a look to the json data)
      List<dynamic> results = data['results'];
      List<Movie> movies = [];
      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getNowPlaying({required int pageNumber}) async {
    Response response = await getData('/movie/now_playing', params: {
      'page': pageNumber,
    });
    if (response.statusCode == 200) {
      Map data = response.data; // Our data output in a json format
      // Professional way to deal with for loop in flutter and dart
      List<Movie> movies = data['results'].map<Movie>((dynamic jsonMovie) {
        return Movie.fromJson(jsonMovie);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getUpcomingMovies({required int pageNumber}) async {
    Response response = await getData('/movie/upcoming', params: {
      'page': pageNumber,
    });
    if (response.statusCode == 200) {
      Map data = response.data; // Our data output in a json format
      // Professional way to deal with for loop in flutter and dart
      List<Movie> movies = data['results'].map<Movie>((dynamic jsonMovie) {
        return Movie.fromJson(jsonMovie);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getAnimationMovies({required int pageNumber}) async {
    Response response = await getData(
      '/discover/movie',
      params: {
        'page': pageNumber,
        'with_genres': '16',
      },
    );
    if (response.statusCode == 200) {
      Map data = response.data; // Our data output in a json format
      // Professional way to deal with for loop in flutter and dart
      List<Movie> movies = data['results'].map<Movie>((dynamic jsonMovie) {
        return Movie.fromJson(jsonMovie);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }

// La dernière function getMovie remplace l'ensemble des fucntions commentés pour un souci de performance et payer moins les frais liés au requêtes API

  // Future<Movie> getMovieDetails({required Movie movie}) async {
  //   Response response = await getData('/movie/${movie.id}');
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> _data = response.data;
  //     var genres = _data['genres'] as List;
  //     List<String> genreList = genres.map((item) {
  //       return item['name'] as String;
  //     }).toList();
  //     Movie newMovie = movie.copyWith(
  //       genres: genreList,
  //       realiseDate: _data['release_date'],
  //       vote: _data['vote_average'],
  //     );

  //     return newMovie;
  //   } else {
  //     throw response;
  //   }
  // }

  // Future<Movie> getMovieVideos({required Movie movie}) async {
  //   Response response = await getData('/movie/${movie.id}/videos');
  //   if (response.statusCode == 200) {
  //     Map _data = response.data;
  //     List<String> videokeys = _data['results'].map<String>((videoJson) {
  //       return videoJson['key'] as String;
  //     }).toList();
  //     return movie.copyWith(videos: videokeys);
  //   } else {
  //     throw response;
  //   }
  // }

  // Future<Movie> getMovieCast({required Movie movie}) async {
  //   Response response = await getData('/movie/${movie.id}/credits');
  //   if (response.statusCode == 200) {
  //     Map _data = response.data;
  //     List<Person> _casting = _data['cast'].map<Person>((dynamic personJson) {
  //       return Person.fromJson(personJson);
  //     }).toList();
  //     return movie.copyWith(casting: _casting);
  //   } else {
  //     throw response;
  //   }
  // }

  // Future<Movie> getMovieImage({required Movie movie}) async {
  //   Response response = await getData(
  //     '/movie/${movie.id}/images',
  //     params: {
  //       'include_image_language': 'null',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     Map _data = response.data;
  //     List<String> _imagePath =
  //         _data['backdrops'].map<String>((dynamic imageJson) {
  //       return imageJson['file_path'] as String;
  //     }).toList();
  //     return movie.copyWith(images: _imagePath);
  //   } else {
  //     throw response;
  //   }
  // }

// Making app more performant by combining requests
  Future<Movie> getMovie({required Movie movie}) async {
    Response response = await getData(
      '/movie/${movie.id}/',
      params: {
        'include_image_language': 'null',
        'append_to_response': 'videos,images,credits'
      },
    );

    if (response.statusCode == 200) {
      Map _data = response.data;

      // get genres data
      var genres = _data['genres'] as List;
      List<String> genreList = genres.map((item) {
        return item['name'] as String;
      }).toList();

      // get movies
      List<String> videokeys =
          _data['videos']['results'].map<String>((videoJson) {
        return videoJson['key'] as String;
      }).toList();

// get images
      List<String> _imagePath =
          _data['images']['backdrops'].map<String>((dynamic imageJson) {
        return imageJson['file_path'] as String;
      }).toList();

      // get movie cast
      List<Person> _casting =
          _data['credits']['cast'].map<Person>((dynamic personJson) {
        return Person.fromJson(personJson);
      }).toList();

      return movie.copyWith(
        videos: videokeys,
        images: _imagePath,
        casting: _casting,
        genres: genreList,
        realiseDate: _data['release_date'],
        vote: _data['vote_average'],
      );
    } else {
      throw response;
    }
  }
}
