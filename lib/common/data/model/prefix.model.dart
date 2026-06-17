import '../../domain/entity/entity.dart';
import 'provider.model.dart';

class PrefixModel {
  const PrefixModel({
    this.id,
    this.prefix,
    this.provider,
  });

  final int? id;
  final String? prefix;
  final ProviderModel? provider;

  factory PrefixModel.fromJson(Map<String, dynamic> json) {
    return PrefixModel(
      id: json['id'] as int?,
      prefix: json['prefix'] as String?,
      provider: json['provider'] == null
          ? null
          : ProviderModel.fromJson(
              json['provider'] as Map<String, dynamic>,
            ),
    );
  }

  PrefixEntity toEntity() {
    return PrefixEntity(
      id: id,
      prefix: prefix,
      provider: provider?.toEntity(),
    );
  }
}
