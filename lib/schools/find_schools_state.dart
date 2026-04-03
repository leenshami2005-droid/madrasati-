import 'package:madrasati_plus/models/schools.dart';

class FindSchoolsState {
  const FindSchoolsState({
    this.schools = const [],
    this.isLoading = false,
    this.searchQuery = '',
    this.errorMessage,
  });

  final List<Schoolmodel> schools;
  final bool isLoading;
  /// Raw text from the search field (for UI).
  final String searchQuery;
  final String? errorMessage;

  FindSchoolsState copyWith({
    List<Schoolmodel>? schools,
    bool? isLoading,
    String? searchQuery,
    String? errorMessage,
    bool clearError = false,
  }) {
    return FindSchoolsState(
      schools: schools ?? this.schools,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
