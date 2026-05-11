import 'package:equatable/equatable.dart';

/// Domain placeholder for one block/section on the landing screen.
/// Template: VS Code snippet `ent` (prefix `ent`).
class LandingItemEntity extends Equatable {
  const LandingItemEntity({
    required this.id,
  });

  final int id;

  @override
  List<Object?> get props => [id];
}
