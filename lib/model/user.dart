class Userr {
  final String id;
  final String email;
  final String name;
  final String phoneNumber;
  final String bio;
  final String imageUrl;
  final List followers;
  Userr(
      {required this.id,
      required this.email,
      required this.name,
      required this.phoneNumber,
      required this.bio,
      required this.imageUrl,
      required this.followers});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'imageUrl': imageUrl,
      'follower': followers
    };
  }
}

Userr fromMap(Map<String, dynamic> map) {
  return Userr(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      bio: map['bio'],
      imageUrl: map['imageUrl'],
      followers: map['follower']);
}
