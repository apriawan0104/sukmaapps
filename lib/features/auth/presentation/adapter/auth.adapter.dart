library;

// Bridges feature UI to external widgets or platform views when needed.
import 'package:riverpod_annotation/riverpod_annotation.dart' hide AsyncValue;
import 'package:app_core/app_core.dart';
import '../../../../common/common.dart';
import '../../../../config/config.dart';
import '../../../../config/navigation/app_router.dart';
import '../../../../config/navigation/route_names.dart';
import '../../domain/usecase/usecase.dart';
import '../controller/auth.controller.dart';
import '../state/auth.state.dart';
part 'auth.adapter.g.dart';

@Riverpod(keepAlive: true)
class AuthAdapter extends _$AuthAdapter implements AuthController {
  late LoginGoogleUseCase _loginGoogleUseCase;
  late LoginAppleUseCase _loginAppleUseCase;
  late ReadTermUseCase _readTermUseCase;

  void _initDependencies() {
    _loginGoogleUseCase = getIt<LoginGoogleUseCase>();
    _loginAppleUseCase = getIt<LoginAppleUseCase>();
    _readTermUseCase = getIt<ReadTermUseCase>();
  }

  @override
  AuthState build() {
    _initDependencies();
    return const AuthState();
  }

  @override
  Future<void> loginWithApple() async {
    state = state.copyWith(loginApple: const AsyncValue.loading());
    final result = await _loginAppleUseCase(NoParams());
    result.fold(
      (failure) {
        FailurePresenter.show(failure);
        state = state.copyWith(
          loginApple: AsyncValue.error(failure),
        );
      },
      (user) {
        state = state.copyWith(
          loginApple: AsyncValue.data(null),
          currentUser: AsyncValue.data(user),
        );
        appRouter.goNamed(RouteNames.landing);
      },
    );
  }

  @override
  Future<void> loginWithGoogle() async {
    state = state.copyWith(loginGoogle: const AsyncValue.loading());
    final result = await _loginGoogleUseCase(NoParams());
    result.fold(
      (failure) {
        FailurePresenter.show(failure);
        state = state.copyWith(
          loginGoogle: AsyncValue.error(failure),
        );
      },
      (user) {
        state = state.copyWith(
          loginGoogle: AsyncValue.data(null),
          currentUser: AsyncValue.data(user),
        );
        appRouter.goNamed(RouteNames.landing);
      },
    );
  }

  @override
  Future<void> readTerm() async {
    final result = await _readTermUseCase(NoParams());
    result.fold(
      FailurePresenter.show,
      (_) {},
    );
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccount() {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }
}
