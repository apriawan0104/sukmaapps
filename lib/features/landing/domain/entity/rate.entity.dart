import 'package:equatable/equatable.dart';

/// Template: VS Code snippet `ent` (prefix `ent`).
class RateEntity extends Equatable {
  const RateEntity({
    this.name,
    this.maksBalance,
    this.minConvert,
    this.maksConvert,
    this.rate,
    this.providerId,
    this.isActive,
  });

  final String? name;
  final int? maksBalance;
  final int? minConvert;
  final int? maksConvert;
  final String? rate;
  final int? providerId;
  final bool? isActive;

  @override
  List<Object?> get props => [
        name,
        maksBalance,
        minConvert,
        maksConvert,
        rate,
        providerId,
        isActive,
      ];
}
