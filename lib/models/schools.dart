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

  // Factory constructor to create a School from a JSON map
  factory Schoolmodel.fromJson(json) {
    return Schoolmodel(
      title: json['title'] ?? '',
      // Accessing nested gps_coordinates from your search results
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      address: json['address'] ?? '',
    );
  }
}
