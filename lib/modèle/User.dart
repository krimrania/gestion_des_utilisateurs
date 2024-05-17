class User {
  int? id;
  String? name;
  String? contact;
  String? description;

  User({this.id, this.name, this.contact, this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'description': description,
    };
  }
}
