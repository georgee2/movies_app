part of 'home_cubit.dart';

class HomeState {
  final bool isLoading;
  final String? errorMessage;
  final List<MovieModel> nowPlaying, topRated, popular;

  HomeState({this.isLoading = false, this.errorMessage, this.nowPlaying = const [], this.topRated = const [], this.popular = const []});

  HomeState copyWith({bool? isLoading, String? errorMessage, List<MovieModel>? nowPlaying, List<MovieModel>? topRated, List<MovieModel>? popular}) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      nowPlaying: nowPlaying ?? this.nowPlaying,
      topRated: topRated ?? this.topRated,
      popular: popular ?? this.popular,
    );
  }
}