class Schoolmodel {
  final String title;
  final double latitude;
  final double longitude;
  final String address;

  Schoolmodel({
    required this.title,
    required this.latitude,
    required this.longitude,
   required this.address,
  });

  factory Schoolmodel.fromJson(Map<String, dynamic> json) {
    double toDouble(dynamic v) {
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v) ?? 0.0;
      return 0.0;
    }

    return Schoolmodel(
      title: json['title']?.toString() ?? '',
      latitude: toDouble(json['latitude']),
      longitude: toDouble(json['longitude']),
      address: json['address']?.toString() ?? '',
    );
  }
}
