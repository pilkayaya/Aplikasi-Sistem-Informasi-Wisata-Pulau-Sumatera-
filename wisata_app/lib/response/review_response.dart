class ReviewResponse {
  final String komentar;
  final String rating;

  ReviewResponse({
    required this.komentar,
    required this.rating,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      komentar: json['komentar'] ?? '',
      rating: json['rating'] ?? '',
    );
  }
}