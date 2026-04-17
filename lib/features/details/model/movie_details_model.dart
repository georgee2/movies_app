import 'package:movies_100/core/app_contstants/app_urls.dart';

class MovieDetailsModel {
  final int id;
  final String title, description, poster;
  final List<String> genres;
  final int runtime;
  final double vote;
  final List<RelatedMovieModel> relatedMovies;

  MovieDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.poster,
    required this.genres,
    required this.runtime,
    required this.vote,
    required this.relatedMovies,
  });

  factory MovieDetailsModel.fromJson(Map json, List<RelatedMovieModel> relatedMovies) {
    return MovieDetailsModel(
      id: json['id'],
      title: json['original_title'],
      description: json['overview'],
      poster: '${AppUrls.imgPath}${json['poster_path']}',
      genres: List<String>.from(json['genres'].map((e) => e['name'])),
      runtime: json['runtime'],
      vote: json['vote_average'],
      relatedMovies: relatedMovies,
    );
  }
}

class RelatedMovieModel {
  final int id;
  final String poster;

  RelatedMovieModel({required this.id, required this.poster});

  factory RelatedMovieModel.fromJson(Map json) {
    return RelatedMovieModel(id: json['id'], poster: '${AppUrls.imgPath}${json['poster_path']}');
  }
}