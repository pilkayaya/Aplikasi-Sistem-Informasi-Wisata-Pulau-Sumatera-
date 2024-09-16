class Review {
  final int id;
  final String userProfile;
  final int userProfileId;
  final String objekWisata;
  final String komentar;
  final String rating;
  final String userCreate;
  final String userUpdate;
  final String createdOn;
  final String lastModified;

  Review({
    required this.id,
    required this.userProfile,
    required this.userProfileId,
    required this.objekWisata,
    required this.komentar,
    required this.rating,
    required this.userCreate,
    required this.userUpdate,
    required this.createdOn,
    required this.lastModified,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_profile': userProfile,
      'user_profile_id': userProfileId,
      'objek_wisata': objekWisata,
      'komentar': komentar,
      'rating': rating,
      'user_create': userCreate,
      'user_update': userUpdate,
      'created_on': createdOn,
      'last_modified': lastModified,
    };
  }
}