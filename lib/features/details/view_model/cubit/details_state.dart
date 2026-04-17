part of 'details_cubit.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {}

final class DetailsLoading extends DetailsState {}
final class DetailsError extends DetailsState {
  final String errorMessage;

  DetailsError(this.errorMessage);
}
final class DetailsLoaded extends DetailsState {
  final MovieDetailsModel details;

  DetailsLoaded(this.details);
}
