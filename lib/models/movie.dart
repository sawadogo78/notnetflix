// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:notnetflix/models/person.dart';

import 'package:notnetflix/services/api.dart';

class Movie {
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final List<String>? genres;
  final String? realiseDate;
  final double? vote;
  final List<String>? videos;
  final List<Person>? casting;
  final List<String>? images;

  Movie(
      {required this.id,
      required this.name,
      required this.overview,
      this.posterPath,
      this.genres,
      this.realiseDate,
      this.vote,
      this.videos,
      this.casting,
      this.images});

  Movie copyWith({
    int? id,
    String? name,
    String? overview,
    String? posterPath,
    List<String>? genres,
    String? realiseDate,
    double? vote,
    List<String>? videos,
    List<Person>? casting,
    List<String>? images,
  }) {
    return Movie(
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      genres: genres ?? this.genres,
      realiseDate: realiseDate ?? this.realiseDate,
      vote: vote ?? this.vote,
      videos: videos ?? this.videos,
      casting: casting ?? this.casting,
      images: images ?? this.images,
    );
  }

// This is usefull when storing data to Firebase
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'overview': overview,
      'posterPath': posterPath,
      'genres': genres,
      'realiseDate': realiseDate,
      'vote': vote,
      'videos': videos,
      'casting': casting,
      'images': images,
    };
  }

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      name: map['title'],
      overview: map['overview'],
      posterPath: map['poster_path'],
    );
  }

  String reformateGenres() {
    String categories = '';
    for (int i = 0; i < genres!.length - 1; i++) {
      if (i == genres!.length - 1) {
        categories = categories + genres![i];
      } else {
        // ignore: prefer_interpolation_to_compose_strings
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
        other.name == name &&
        other.overview == overview &&
        other.posterPath == posterPath &&
        listEquals(other.genres, genres) &&
        other.realiseDate == realiseDate &&
        other.vote == vote;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        overview.hashCode ^
        posterPath.hashCode ^
        genres.hashCode ^
        realiseDate.hashCode ^
        vote.hashCode;
  }
}


// Note that thanks to dart data class generator extension, all of this is automately generated. So when I am tring to use it, I just need to remove what I don't want