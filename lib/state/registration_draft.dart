class RegistrationDraft {
  RegistrationDraft._();

  static final RegistrationDraft instance = RegistrationDraft._();

  String? childName;
  String? nationalId;
  DateTime? birthDate;
  String? gender;
  String? grade;
  bool? transferred;
  bool? specialNeeds;

  /// Step 3 — اسم المدرسة وعنوانها (القيم المعتمدة للعرض)
  static const String defaultSchoolName = 'school1';
  static const String defaultSchoolAddress = 'المدرسه القريبه';

  String? selectedSchoolName = defaultSchoolName;
  String? selectedSchoolAddress = defaultSchoolAddress;

  /// Step 2 — optional display lines for uploaded docs (set when user taps تحميل)
  String? birthCertificateFileLine;
  String? vaccinationRecordFileLine;
  String? transferCertificateFileLine;

  /// Address if you add a field later; otherwise confirm shows "—"
  String? address;

  String get birthDateText {
    final d = birthDate;
    if (d == null) return '';
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.day)}/${two(d.month)}/${d.year}';
  }

  /// Father name = 2nd, 3rd, and 4th words of the full name field (index 1..3).
  String get fatherNameFromNameParts {
    final raw = childName?.trim();
    if (raw == null || raw.isEmpty) return '—';
    final parts = raw.split(RegExp(r'\s+')).where((s) => s.isNotEmpty).toList();
    if (parts.length < 2) return '—';
    final from = 1;
    final to = parts.length >= 4 ? 4 : parts.length;
    return parts.sublist(from, to).join(' ');
  }

  void clearSchoolSelection() {
    selectedSchoolName = defaultSchoolName;
    selectedSchoolAddress = defaultSchoolAddress;
  }
}

