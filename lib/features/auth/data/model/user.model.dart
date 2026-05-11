import '../../domain/entity/entity.dart';

class UserModel {
  const UserModel({
    this.user,
    this.token,
  });

  final UserDetailModel? user;
  final String? token;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      user: json['user'] as UserDetailModel?,
      token: json['token'] as String?,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      user: user?.toEntity(),
      token: token ?? '',
    );
  }
}

class UserDetailModel {
  const UserDetailModel({
    this.id,
    this.fullname,
    this.email,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.isReadTermCondition,
  });

  final int? id;
  final String? fullname;
  final String? email;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;
  final bool? isReadTermCondition;

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
      id: json['id'] as int?,
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      isReadTermCondition: json['isReadTermCondition'] as bool?,
    );
  }

  UserDetailEntity toEntity() {
    return UserDetailEntity(
      id: id ?? 0,
      fullname: fullname ?? '',
      email: email ?? '',
      isActive: isActive ?? false,
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
      isReadTermCondition: isReadTermCondition ?? false,
    );
  }
}
