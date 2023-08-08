// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:notnetflix/services/api.dart';

class Movie {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
  });

  Movie copyWith({
    int? id,
    String? title,
    String? overview,
    String? posterPath,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
    );
  }

// This is usefull when storing data to Firebase
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'overview': overview,
      'posterPath': posterPath,
    };
  }

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      title: map['title'] as String,
      overview: map['overview'] as String,
      posterPath:
          map['poster_path'] != null ? map['poster_path'] as String : null,
    );
  }

  // Function to get poster Url
  String posterUrl() {
    API api = API();
    return api.baseImageURL + posterPath!;
  }

// This is useful when converting data to json format and send it to storage that only accept json format as data format
  String toJson() => json.encode(toMap());

// This allow to compare to Movie
  @override
  bool operator ==(covariant Movie other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.overview == overview &&
        other.posterPath == posterPath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        overview.hashCode ^
        posterPath.hashCode;
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      title: map['title'] as String,
      overview: map['overview'] as String,
      posterPath:
          map['posterPath'] != null ? map['posterPath'] as String : null,
    );
  }
}


// Note that thanks to dart data class generator extension, all of this is automately generated. So when I am tring to use it, I just need to remove what I don't want