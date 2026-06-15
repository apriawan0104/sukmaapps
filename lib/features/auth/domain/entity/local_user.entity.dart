import 'package:equatable/equatable.dart';

class LocalUserEntity extends Equatable {
  const LocalUserEntity({
    required this.userId,
    required this.fullname,
    required this.foto,
  });

  final String userId;
  final String fullname;
  final String foto;

  @override
  List<Object?> get props => [userId, fullname, foto];
}
