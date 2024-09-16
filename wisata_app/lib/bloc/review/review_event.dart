part of 'review_bloc.dart';

@immutable
abstract class ReviewEvent {}

class LoadReviews extends ReviewEvent {}

class AddReview extends ReviewEvent {
  final ReviewParam reviewParam;

  AddReview(this.reviewParam);
}

class UpdateReview extends ReviewEvent {
  final int id;
  final ReviewParam reviewParam;

  UpdateReview(this.id, this.reviewParam);
}

class DeleteReview extends ReviewEvent {
  final int id;

  DeleteReview(this.id);
}