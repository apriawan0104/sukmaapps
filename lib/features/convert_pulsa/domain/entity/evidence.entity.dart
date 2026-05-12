import 'package:equatable/equatable.dart';

class EvidenceEntity extends Equatable {
  const EvidenceEntity({
    this.imageId,
  });

  final int? imageId;

  @override
  List<Object?> get props => [imageId];
}
