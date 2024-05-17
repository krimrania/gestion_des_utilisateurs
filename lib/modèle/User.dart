class User {
  final int? id;
  final String name;
  final String contact;
  final String description;

  User({
    this.id,
    required this.name,
    required this.contact,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'description': description,
    };
  }

  static Future<User?> fromMap(Map<String, dynamic> userMap) async {
    if (userMap.isNotEmpty) {
      return User(
        id: userMap['id'],
        name: userMap['name'],
        contact: userMap['contact'],
        description: userMap['description'],
      );
    } else {
      return null;
    }
  }
}
