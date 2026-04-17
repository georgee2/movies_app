import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies_100/core/app_contstants/app_urls.dart';
import 'package:movies_100/core/app_contstants/end_points.dart';
import 'package:movies_100/features/home/model/movie_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  Future<void> getMovies() async {
    emit(state.copyWith(isLoading: true));
    List<MovieModel> nowPlaying = await getMoviesList(EndPoints.nowPlaying);
    List<MovieModel> topRated = await getMoviesList(EndPoints.topRated);
    List<MovieModel> popular = await getMoviesList(EndPoints.popular);
    emit(state.copyWith(
      isLoading: false,
      nowPlaying: nowPlaying,
      topRated: topRated,
      popular: popular,
    ));
  }
  Future<List<MovieModel>> getMoviesList(String endpoint) async {
    try {
      Uri url = Uri.parse('${AppUrls.baseUrl}$endpoint');
      final header = {
        'accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3YjkwMGE1MjQwOTZhYjBiYWU2YWQ3ZWVhNjhiODExYiIsIm5iZiI6MTY4MDQ1MDI1OC4xMjEsInN1YiI6IjY0MjlhMmQyOGRlMGFlMDBmNGMwNzdkZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.uTB6Z-8-tUHUrNPEO5_iljNEYB0w6vW8SLo8t4LfIHc',
      };
      final response = await http.get(url, headers: header);

      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<MovieModel>.from(data['results'].map((m) => MovieModel.fromJson(m)));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}