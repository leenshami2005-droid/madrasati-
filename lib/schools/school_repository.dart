import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:madrasati_plus/models/schools.dart';

/// Firestore access for schools. Nearby list uses a live snapshot; search uses
/// a server-side prefix query on [title] (requires each document to have `title`).
class SchoolRepository {
  SchoolRepository({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  CollectionReference get _schools => _db.collection('schools');

  static Map<String, dynamic> _docData(DocumentSnapshot d) {
    final data = d.data();
    if (data == null) return {};
    if (data is Map<String, dynamic>) return data;
    return Map<String, dynamic>.from(data as Map);
  }

  static double _km(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000;
  }

  /// All schools from Firestore, filtered to [maxKm] radius (client-side).
  Stream<List<Schoolmodel>> watchNearbySchools({
    required double userLat,
    required double userLong,
    double maxKm = 10,
  }) {
    return _schools.snapshots().map((snap) {
      final list = snap.docs
          .map((d) => Schoolmodel.fromJson(_docData(d)))
          .where((s) =>
              _km(userLat, userLong, s.latitude, s.longitude) <= maxKm)
          .toList();
      return list;
    });
  }

  /// Firestore prefix search on `title` — **no** distance filter (anywhere in the DB).
  ///
  /// Uses `orderBy('title').startAt([prefix]).endAt([prefix + '\\uf8ff'])`.
  Future<List<Schoolmodel>> searchByTitlePrefix(String prefix) async {
    final q = prefix.trim();
    if (q.isEmpty) return [];

    final snapshot = await _schools
        .orderBy('title')
        .startAt([q])
        .endAt(['$q\uf8ff'])
        .get();

    return snapshot.docs
        .map((d) => Schoolmodel.fromJson(_docData(d)))
        .toList();
  }
}
