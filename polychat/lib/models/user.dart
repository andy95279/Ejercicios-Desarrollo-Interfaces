class User {
  final String id;
  final String email;
  final String name;
  final String? lastName;
  final String? phoneNumber;
  final int? age;
  final String? language;
  final String? profileImageUrl;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.lastName,
    this.phoneNumber,
    this.age,
    this.language,
    this.profileImageUrl,
  });

  User copyWith({
    String? email,
    String? name,
    String? lastName,
    String? phoneNumber,
    int? age,
    String? language,
    String? profileImageUrl,
  }) {
    return User(
      id: id,
      email: email ?? this.email,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      age: age ?? this.age,
      language: language ?? this.language,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
