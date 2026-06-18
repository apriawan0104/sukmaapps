import 'package:equatable/equatable.dart';

class StatusTransaksiEntity extends Equatable {
  const StatusTransaksiEntity({
    this.id,
    this.nameProvider,
    this.noTrans,
    this.description,
  });

  final int? id;
  final String? nameProvider;
  final String? noTrans;
  final String? description;

  @override
  List<Object?> get props => [id, nameProvider, noTrans, description];
}
