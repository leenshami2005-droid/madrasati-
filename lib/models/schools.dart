class Schoolmodel {
  final String title;
  final double latitude;
  final double longitude;
  final String address;
  final String catg;
  final bool specailneeds;
  /// Second line under title, e.g. "مدرسة أساسية — صفوف ١ إلى ١٠" (optional in Firestore).
  final String subtitle;

  Schoolmodel({
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.catg,
    required this.specailneeds,
    this.subtitle = '',
  });

  static bool _parseBool(dynamic v) {
    if (v is bool) return v;
    if (v is num) return v != 0;
    if (v is String) {
      final s = v.toLowerCase().trim();
      return s == 'true' || s == '1' || s == 'yes';
    }
    return false;
  }

  factory Schoolmodel.fromJson(Map<String, dynamic> json) {
    double toDouble(dynamic v) {
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v) ?? 0.0;
      return 0.0;
    }

    final sn = json['specialneeds'] ?? json['specailneeds'] ?? json['special_needs'];

    return Schoolmodel(
      title: json['title']?.toString() ?? '',
      latitude: toDouble(json['latitude']),
      longitude: toDouble(json['longitude']),
      address: json['address']?.toString() ?? '',
      catg: json['catg']?.toString() ?? '',
      specailneeds: _parseBool(sn),
      subtitle: json['subtitle']?.toString() ??
          json['sub_title']?.toString() ??
          '',
    );
  }
}
