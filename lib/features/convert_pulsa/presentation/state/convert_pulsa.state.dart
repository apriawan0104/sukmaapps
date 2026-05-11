import 'package:equatable/equatable.dart';

import '../../domain/entity/entity.dart';

/// Template: VS Code snippet `stte` (prefix `stte`).
/// Saat [CustomAsyncValue] sudah tersedia di app_core, migrasikan field `items`.
class ConvertPulsaState extends Equatable {
  const ConvertPulsaState({
    this.items = const <ConvertPulsaItemEntity>[],
    this.isLoading = false,
    this.errorMessage,
  });

  final List<ConvertPulsaItemEntity> items;
  final bool isLoading;
  final String? errorMessage;

  @override
  List<Object?> get props => [items, isLoading, errorMessage];

  ConvertPulsaState copyWith({
    List<ConvertPulsaItemEntity>? items,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ConvertPulsaState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
