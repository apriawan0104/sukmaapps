import 'package:equatable/equatable.dart';

/// Template: VS Code snippet `ent` (prefix `ent`).
class InformationBannerEntity extends Equatable {
  const InformationBannerEntity({
    this.type,
    this.description,
  });

  final String? type;
  final String? description;

  @override
  List<Object?> get props => [type, description];
}
