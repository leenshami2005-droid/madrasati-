class Student {
  Student({this.name, this.section, this.grade, this.absenccepermonth,this.attendance,this.id, this.late,this.totabsence});

  String? name;
  String? grade;
  String? section;
String? id;
int? absenccepermonth;
int? totabsence;
int? late;
int? attendance;

  factory Student.fromJson(json) {
    return Student(
      name: json["name"],
      grade: json["grade"],
      section: json["section"],
      id: json["parentid"],
      absenccepermonth: json["absense-month"],
      attendance: json["attendance"],
      late: json["late"],
      totabsence: json["totabsence"],

    );
  }
}
