// Holds presentation-facing auth state (loading, errors, form values).
// Wire to Riverpod/Bloc/etc. when you add state management.
library;

import 'package:equatable/equatable.dart';
import 'package:app_core/app_core.dart';

import '../../domain/entity/entity.dart';

class AuthState extends Equatable {
  const AuthState({
    this.loginGoogle,
    this.loginApple,
    this.currentUser,
  });

  final AsyncValue<void>? loginGoogle;
  final AsyncValue<void>? loginApple;
  final AsyncValue<UserEntity>? currentUser;

  @override
  List<Object?> get props => [loginGoogle, loginApple, currentUser];

  AuthState copyWith({
    AsyncValue<void>? loginGoogle,
    AsyncValue<void>? loginApple,
    AsyncValue<UserEntity>? currentUser,
  }) {
    return AuthState(
      loginGoogle: loginGoogle ?? this.loginGoogle,
      loginApple: loginApple ?? this.loginApple,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
