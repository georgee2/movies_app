import '../../../core/app_contstants/app_urls.dart';

class MovieModel {
  final int id;
  final String posterPath;

  MovieModel({required this.id, required this.posterPath});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      posterPath: '${AppUrls.imgPath}${json['poster_path']}',
    );
  }
}