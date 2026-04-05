class Student {
  Student({
    this.name,
    this.grade,
    this.section,
    this.id,
    this.schoolName,
    this.primaryTeacher,
    this.parentName,
    this.absenccepermonth,
    this.totabsence,
    this.late,
    this.attendance,
  });

  String? name;
  String? grade;
  String? section;
  /// Student id from Firestore field `id` (see [fromJson] fallbacks).
  String? id;
  String? schoolName;
  String? primaryTeacher;
  String? parentName;
  int? absenccepermonth;
  int? totabsence;
  int? late;
  int? attendance;

  String get gradeSectionLabel {
    final g = grade?.trim();
    final s = section?.trim();
    if ((g == null || g.isEmpty) && (s == null || s.isEmpty)) return '—';
    if (g != null && g.isNotEmpty && s != null && s.isNotEmpty) {
      return '$g — $s';
    }
    return (g != null && g.isNotEmpty) ? g : (s ?? '—');
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    int? toInt(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      if (v is num) return v.toInt();
      return int.tryParse(v.toString());
    }

    String? str(dynamic v) => v?.toString();

    return Student(
      name: str(json['name']),
      grade: str(json['grade']),
      section: str(json['section']),
      id: str(json['id']) ??
          str(json['studentId']) ??
          str(json['student_code']) ??
          str(json['stuId']) ??
          str(json['studentNumber']),
      schoolName: str(json['schoolName']) ?? str(json['school']),
      primaryTeacher: str(json['primaryTeacher']) ??
          str(json['homeroomTeacher']) ??
          str(json['teacher']),
      parentName: str(json['parentName']) ??
          str(json['guardianName']) ??
          str(json['parent_name']),
      absenccepermonth: toInt(json['absense-month'] ?? json['absence-month']),
      attendance: toInt(json['attendance']),
      late: toInt(json['late']),
      totabsence: toInt(json['totabsence']),
    );
  }
}
