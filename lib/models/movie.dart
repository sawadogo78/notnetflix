// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:notnetflix/services/api.dart';

class Movie {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final List<String>? genres;
  final String? realiseDate;
  final double? vote;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.genres,
    this.realiseDate,
    this.vote,
  });

  Movie copyWith({
    int? id,
    String? title,
    String? overview,
    String? posterPath,
    List<String>? genres,
    String? realiseDate,
    double? vote,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      genres: genres ?? this.genres,
      realiseDate: realiseDate ?? this.realiseDate,
      vote: vote ?? this.vote,
    );
  }

// This is usefull when storing data to Firebase
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'overview': overview,
      'posterPath': posterPath,
      'genres': genres,
      'realiseDate': realiseDate,
      'vote': vote,
    };
  }

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      title: map['title'] as String,
      overview: map['overview'] as String,
      posterPath:
          map['posterPath'] != null ? map['posterPath'] as String : null,
      genres: map['genres'] != null
          ? List<String>.from((map['genres'] as List<String>))
          : null,
      realiseDate:
          map['realiseDate'] != null ? map['realiseDate'] as String : null,
      vote: map['vote'] != null ? map['vote'] as double : null,
    );
  }

  String reformateGenres() {
    String categories = '';
    for (int i = 0; i < genres!.length - 1; i++) {
      if (i == genres!.length - 1) {
        categories = categories + genres![i];
      } else {
        categories = categories + '${genres![i]}, ';
      }
    }
    return categories;
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
        other.posterPath == posterPath &&
        listEquals(other.genres, genres) &&
        other.realiseDate == realiseDate &&
        other.vote == vote;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        overview.hashCode ^
        posterPath.hashCode ^
        genres.hashCode ^
        realiseDate.hashCode ^
        vote.hashCode;
  }
}


// Note that thanks to dart data class generator extension, all of this is automately generated. So when I am tring to use it, I just need to remove what I don't want