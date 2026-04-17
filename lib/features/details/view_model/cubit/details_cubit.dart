import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../core/app_contstants/app_urls.dart';
import '../../model/movie_details_model.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  Future<void> prepareMovie(int id) async {
    emit(DetailsLoading());
    List<RelatedMovieModel> related = await getRelatedMovies(id);
    try {
      Uri url = Uri.parse('${AppUrls.baseUrl}movie/$id');
      final header = {
        'accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3YjkwMGE1MjQwOTZhYjBiYWU2YWQ3ZWVhNjhiODExYiIsIm5iZiI6MTY4MDQ1MDI1OC4xMjEsInN1YiI6IjY0MjlhMmQyOGRlMGFlMDBmNGMwNzdkZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.uTB6Z-8-tUHUrNPEO5_iljNEYB0w6vW8SLo8t4LfIHc',
      };
      final response = await http.get(url, headers: header);

      print(response.statusCode);
      print(related.length);
      print(response.body);

      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        MovieDetailsModel details = MovieDetailsModel.fromJson(data, related);
        emit(DetailsLoaded(details));
      } else {
        emit(DetailsError('Something went wrong'));
      }
    } catch (e) {
      emit(DetailsError('Something went wrong'));
    }
  }
  Future<List<RelatedMovieModel>> getRelatedMovies(int id) async {
    try {
      Uri url = Uri.parse('${AppUrls.baseUrl}movie/$id/similar');
      final header = {
        'accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3YjkwMGE1MjQwOTZhYjBiYWU2YWQ3ZWVhNjhiODExYiIsIm5iZiI6MTY4MDQ1MDI1OC4xMjEsInN1YiI6IjY0MjlhMmQyOGRlMGFlMDBmNGMwNzdkZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.uTB6Z-8-tUHUrNPEO5_iljNEYB0w6vW8SLo8t4LfIHc',
      };
      final response = await http.get(url, headers: header);

      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<RelatedMovieModel>.from(data['results'].map((m) => RelatedMovieModel.fromJson(m)));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
