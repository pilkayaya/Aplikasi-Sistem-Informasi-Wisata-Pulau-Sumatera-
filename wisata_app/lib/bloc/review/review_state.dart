part of 'review_bloc.dart';

@immutable
abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final List<ReviewResponse> reviews;

  ReviewLoaded({required this.reviews});
}

class ReviewAdded extends ReviewState {
  final ReviewResponse reviewResponse;

  ReviewAdded({required this.reviewResponse});
}

class ReviewUpdated extends ReviewState {}

class ReviewDeleted extends ReviewState {}

class ReviewError extends ReviewState {
  final String message;

  ReviewError({required this.message});
}