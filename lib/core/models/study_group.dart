class StudyGroup {
  final String id;
  final String name;

  StudyGroup({required this.id, required this.name});

  factory StudyGroup.fromJson(Map<String, dynamic> json) {
    return StudyGroup(id: json['id'], name: json['name']);
  }
}
