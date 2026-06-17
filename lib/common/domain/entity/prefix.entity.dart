import 'package:equatable/equatable.dart';

import 'provider.entity.dart';

class PrefixEntity extends Equatable {
  const PrefixEntity({
    this.id,
    this.prefix,
    this.provider,
  });

  final int? id;
  final String? prefix;
  final ProviderEntity? provider;

  @override
  List<Object?> get props => [
        id,
        prefix,
        provider,
      ];
}
