import 'package:equatable/equatable.dart';

class PhoneFavEntity extends Equatable {
  const PhoneFavEntity({
    this.id,
    this.number,
    this.provider,
    this.rate,
    this.providerId,
    this.maksConvert,
    this.minConvert,
  });

  final int? id;
  final String? number;
  final String? provider;
  final String? rate;
  final int? providerId;
  final int? maksConvert;
  final int? minConvert;

  @override
  List<Object?> get props =>
      [id, number, provider, rate, providerId, maksConvert, minConvert];
}
