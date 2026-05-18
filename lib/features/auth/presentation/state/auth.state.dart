// Holds presentation-facing auth state (loading, errors, form values).
// Wire to Riverpod/Bloc/etc. when you add state management.
library;

import 'package:equatable/equatable.dart';
import 'package:app_core/app_core.dart';

class AuthState extends Equatable {
  const AuthState({
    this.loginGoogle = const AsyncValue<void>.loading(),
    this.loginApple = const AsyncValue<void>.loading(),
  });

  final AsyncValue<void>? loginGoogle;
  final AsyncValue<void>? loginApple;

  @override
  List<Object?> get props => [loginGoogle, loginApple];

  AuthState copyWith({
    AsyncValue<void>? loginGoogle,
    AsyncValue<void>? loginApple,
  }) {
    return AuthState(
      loginGoogle: loginGoogle ?? this.loginGoogle,
      loginApple: loginApple ?? this.loginApple,
    );
  }
}
