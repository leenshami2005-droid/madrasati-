class Student {
  Student({this.name, this.section, this.grade});

  String? name;
  String? grade;
  String? section;

  factory Student.fromJson(json) {
    return Student(
      name: json["name"],
      grade: json["grade"],
      section: json["section"],
    );
  }
}
