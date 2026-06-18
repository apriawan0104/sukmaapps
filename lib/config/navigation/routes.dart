import 'package:go_router/go_router.dart';
import '../../common/common.dart';
import '../../features/auth/presentation/screen/screen.dart';
import '../../features/convert_pulsa/presentation/page/page.dart';
import '../../features/landing/presentation/screen/landing.screen.dart';
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
  GoRoute(
    path: '/landing',
    name: RouteNames.landing,
    builder: (context, state) => const LandingScreen(),
  ),
  GoRoute(
    path: '/phone',
    name: RouteNames.phone,
    builder: (context, state) => const PhoneSenderPage(),
  ),
  GoRoute(
    path: '/nominal',
    name: RouteNames.nominal,
    builder: (context, state) => const TopUpCreditPage(),
  ),
  GoRoute(
    path: '/rekening',
    name: RouteNames.rekening,
    builder: (context, state) => const RekeningPage(),
  ),
  GoRoute(
    path: '/konfirmasi',
    name: RouteNames.konfirmasi,
    builder: (context, state) => const KonfirmasiPage(),
  ),
  GoRoute(
    path: '/transfer',
    name: RouteNames.transfer,
    builder: (context, state) => const TransferPage(),
  ),
];
