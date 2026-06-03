library;

// Bridges feature UI to external widgets or platform views when needed.
import 'package:riverpod_annotation/riverpod_annotation.dart' hide AsyncValue;
import 'package:app_core/app_core.dart';
import '../../../../config/navigation/app_router.dart';
import '../../../../config/navigation/route_names.dart';
import '../../domain/usecase/usecase.dart';
import '../controller/auth.controller.dart';
import '../state/auth.state.dart';
part 'auth.adapter.g.dart';

@riverpod
class AuthAdapter extends _$AuthAdapter implements AuthController {
  late LoginGoogleUseCase _loginGoogleUseCase;
  late LoginAppleUseCase _loginAppleUseCase;

  void _initDependencies() {
    _loginGoogleUseCase = getIt<LoginGoogleUseCase>();
    _loginAppleUseCase = getIt<LoginAppleUseCase>();
  }

  @override
  AuthState build() {
    _initDependencies();
    return const AuthState();
  }

  @override
  Future<void> loginWithApple() async {
    final result = await _loginAppleUseCase(NoParams());
    state = state.copyWith(
      loginApple: result.fold(
        (failure) => AsyncValue.error(failure.message),
        AsyncValue.data,
      ),
    );
  }

  @override
  Future<void> loginWithGoogle() async {
    // final result = await _loginGoogleUseCase(NoParams());
    // result.fold(
    //   (failure) {
    //     state = state.copyWith(
    //       loginGoogle: AsyncValue.error(failure.message),
    //     );
    //   },
    //   (_) {
    //     state = state.copyWith(
    //       loginGoogle: const AsyncValue.data(null),
    //     );
    //     appRouter.goNamed(RouteNames.landing);
    //   },
    // );
    appRouter.goNamed(RouteNames.landing);
  }

  @override
  Future<void> readTerm() {
    // TODO: implement readTerm
    throw UnimplementedError();
  }
}
