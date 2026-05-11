import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.user,
    required this.token,
  });

  final UserDetailEntity? user;
  final String? token;

  @override
  List<Object?> get props => [user, token];
}

class UserDetailEntity extends Equatable {
  const UserDetailEntity({
    required this.id,
    required this.fullname,
    required this.email,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.isReadTermCondition,
  });

  final int id;
  final String fullname;
  final String email;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final bool isReadTermCondition;

  @override
  List<Object?> get props => [
        id,
        fullname,
        email,
        isActive,
        createdAt,
        updatedAt,
        isReadTermCondition
      ];
}
