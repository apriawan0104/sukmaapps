import 'package:equatable/equatable.dart';

class ProviderEntity extends Equatable {
  const ProviderEntity({
    this.id,
    this.name,
    this.maksBalance,
    this.maksConvert,
    this.minConvert,
    this.rate,
    this.formatTransfer,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final int? maksBalance;
  final int? maksConvert;
  final int? minConvert;
  final String? rate;
  final String? formatTransfer;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [
        id,
        name,
        maksBalance,
        maksConvert,
        minConvert,
        rate,
        formatTransfer,
        status,
        createdAt,
        updatedAt
      ];
}
