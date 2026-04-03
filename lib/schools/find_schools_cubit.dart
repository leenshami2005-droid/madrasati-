import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati_plus/models/schools.dart';
import 'package:madrasati_plus/schools/find_schools_state.dart';
import 'package:madrasati_plus/schools/school_repository.dart';

/// Manages nearby schools (stream) vs Firestore prefix search when the user types.
class FindSchoolsCubit extends Cubit<FindSchoolsState> {
  FindSchoolsCubit(
    this._repo,
    this.userLat,
    this.userLong,
  ) : super(const FindSchoolsState());

  final SchoolRepository _repo;
  final double userLat;
  final double userLong;

  static const double _radiusKm = 10;
  static const Duration _searchDebounce = Duration(milliseconds: 400);

  StreamSubscription<List<Schoolmodel>>? _nearbySub;
  Timer? _debounce;

  /// Start listening to all schools in radius (no search filter).
  Future<void> start() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    await _nearbySub?.cancel();
    _nearbySub = _repo
        .watchNearbySchools(
          userLat: userLat,
          userLong: userLong,
          maxKm: _radiusKm,
        )
        .listen(
          (list) {
            emit(state.copyWith(
              schools: list,
              isLoading: false,
              clearError: true,
            ));
          },
          onError: (Object e) {
            emit(state.copyWith(
              isLoading: false,
              errorMessage: e.toString(),
            ));
          },
        );
  }

  /// Call on each keystroke; debounced. Empty query reloads the nearby stream.
  void updateSearchQuery(String raw) {
    emit(state.copyWith(searchQuery: raw));
    _debounce?.cancel();
    _debounce = Timer(_searchDebounce, () async {
      final trimmed = raw.trim();
      if (trimmed.isEmpty) {
        await start();
        return;
      }
      await _searchFirestore(trimmed);
    });
  }

  Future<void> _searchFirestore(String prefix) async {
    await _nearbySub?.cancel();
    _nearbySub = null;
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final list = await _repo.searchByTitlePrefix(prefix);
      emit(state.copyWith(schools: list, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    _nearbySub?.cancel();
    return super.close();
  }
}
