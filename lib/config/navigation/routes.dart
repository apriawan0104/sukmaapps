import 'package:go_router/go_router.dart';
import '../../common/common.dart';
import '../../features/auth/presentation/screen/screen.dart';
import '../environment/environment.dart';
import 'route_names.dart';

List<RouteBase> routes = [
  GoRoute(
    path: '/',
    name: RouteNames.login,
    builder: (context, state) => UIBannerEnv.banner(
      EnvironmentConfig.current,
      const LoginScreen(),
    ),
  ),
  GoRoute(
    path: '/privacy-policy',
    name: RouteNames.privacyPolicy,
    builder: (context, state) =>
        const PrivacyPolicyScreen(mdFileName: 'privacy_policy.md'),
  ),
  GoRoute(
    path: '/term-condition',
    name: RouteNames.termCondition,
    builder: (context, state) =>
        const TermConditionScreen(mdFileName: 'term_condition.md'),
  ),
];
