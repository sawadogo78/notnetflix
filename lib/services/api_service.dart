import 'package:dio/dio.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/services/api.dart';

class APIService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    // Let build our URL witch will be called
    // ignore: no_leading_underscores_for_local_identifiers
    String _url = api.baseUrl + path;
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

    final response = await dio.get(_url, queryParameters: query);
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

  Future<Movie> getMovieDetails({required Movie movie}) async {
    Response response = await getData('movie/${movie.id}');
    if (response.statusCode == 200) {
      Map<String, dynamic> _data = response.data;
      var genres = _data['genres'] as List;
      List<String> genreList = genres.map((item) {
        return item['name'] as String;
      }).toList();
      Movie newMovie = movie.copyWith(
        genres: genreList,
        realiseDate: _data['release_date'],
        vote: _data['vote_average'],
      );

      return newMovie;
    } else {
      throw response;
    }
  }
}
