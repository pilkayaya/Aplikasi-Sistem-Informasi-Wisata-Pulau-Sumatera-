class ReviewParam {
  final int userProfileId;
  final String objekWisata;
  final String komentar;
  final String rating;

  ReviewParam({
    required this.userProfileId,
    required this.objekWisata,
    required this.komentar,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_profile_id': userProfileId,
      'objek_wisata': objekWisata,
      'komentar': komentar,
      'rating': rating,
    };
  }
}