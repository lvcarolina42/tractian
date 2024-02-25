class Location {
  final String name;
  final String id;
  final String? parentId;

  Location({required this.name, required this.id, required this.parentId});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      id: json['id'],
      parentId: json['parentId'],
    );
  }
}