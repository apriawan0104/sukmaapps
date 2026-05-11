import 'package:equatable/equatable.dart';

import '../../domain/entity/entity.dart';

/// Template: VS Code snippet `stte` (prefix `stte`).
/// Saat [CustomAsyncValue] sudah tersedia di app_core, migrasikan field `sections`.
class LandingState extends Equatable {
  const LandingState({
    this.sections = const <LandingItemEntity>[],
    this.isLoading = false,
    this.errorMessage,
  });

  final List<LandingItemEntity> sections;
  final bool isLoading;
  final String? errorMessage;

  @override
  List<Object?> get props => [sections, isLoading, errorMessage];

  LandingState copyWith({
    List<LandingItemEntity>? sections,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LandingState(
      sections: sections ?? this.sections,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
