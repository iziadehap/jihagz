class Profile {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String gender;
  final int age;
  final int points;
  final String profile_image;
  final String createdAt;

  Profile({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.gender,
    required this.age,
    required this.points,
    required this.profile_image,
    required this.createdAt,
  });
}

class ProfileModel {
  final String id = 'id';
  final String email = 'email';
  final String name = 'name';
  final String phone = 'phone';
  final String gender = 'gender';
  final String age = 'age';
  final String points = 'points';
  final String profile_image = 'profile_image';
  final String createdAt = 'created_at';
}
