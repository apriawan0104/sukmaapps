import 'package:equatable/equatable.dart';

/// Placeholder domain object untuk fitur common (isi sesuai kebutuhan nanti).
class CommonItemEntity extends Equatable {
  const CommonItemEntity({
    required this.id,
  });

  final int id;

  @override
  List<Object?> get props => [id];
}
