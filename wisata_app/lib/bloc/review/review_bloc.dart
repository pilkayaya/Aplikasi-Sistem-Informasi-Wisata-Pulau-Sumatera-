import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../params/review_param.dart';
import '../../core/api_exception.dart';
import '../../response/review_response.dart';
import '../../repo/review_repository.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository reviewRepository;

  ReviewBloc({required this.reviewRepository}) : super(ReviewInitial()) {
    on<LoadReviews>((event, emit) async {
      emit(ReviewLoading());
      try {
        final reviews = await reviewRepository.fetchReviews();
        emit(ReviewLoaded(reviews: reviews));
      } catch (error) {
        if (error is ApiException) {
          emit(ReviewError(message: error.message));
        } else {
          emit(ReviewError(message: error.toString()));
        }
      }
    });

    on<AddReview>((event, emit) async {
      try {
        final reviewResponse = await reviewRepository.createReview(event.reviewParam);
        emit(ReviewAdded(reviewResponse: reviewResponse));
        add(LoadReviews());
      } catch (error) {
        if (error is ApiException) {
          emit(ReviewError(message: error.message));
        } else {
          emit(ReviewError(message: error.toString()));
        }
      }
    });

    on<UpdateReview>((event, emit) async {
      try {
        await reviewRepository.updateReview(event.id, event.reviewParam);
        emit(ReviewUpdated());
        add(LoadReviews());
      } catch (error) {
        if (error is ApiException) {
          emit(ReviewError(message: error.message));
        } else {
          emit(ReviewError(message: error.toString()));
        }
      }
    });

    on<DeleteReview>((event, emit) async {
      try {
        await reviewRepository.deleteReview(event.id);
        emit(ReviewDeleted());
        add(LoadReviews());
      } catch (error) {
        if (error is ApiException) {
          emit(ReviewError(message: error.message));
        } else {
          emit(ReviewError(message: error.toString()));
        }
      }
    });
  }
}