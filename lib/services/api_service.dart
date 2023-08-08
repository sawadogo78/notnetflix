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
}
