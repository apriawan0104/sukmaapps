import 'package:equatable/equatable.dart';

/// Domain placeholder untuk satu item/alur convert pulsa.
/// Template: VS Code snippet `ent` (prefix `ent`).
class ConvertPulsaItemEntity extends Equatable {
  const ConvertPulsaItemEntity({
    required this.id,
  });

  final int id;

  @override
  List<Object?> get props => [id];
}
