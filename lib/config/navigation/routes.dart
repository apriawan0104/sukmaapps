import 'package:go_router/go_router.dart';

import '../../common/common.dart';
import '../../features/auth/presentation/screen/screen.dart';
import '../../features/convert_pulsa/presentation/page/page.dart';
import '../../features/landing/presentation/page/page.dart';
import '../../features/landing/presentation/screen/landing.screen.dart';
import '../environment/environment.dart';
import 'route_names.dart';

List<RouteBase> routes = [
  GoRoute(
    path: RouteNames.login,
    name: RouteNames.login,
    builder: (context, state) => UIBannerEnv.banner(
      EnvironmentConfig.current,
      const LoginScreen(),
    ),
    routes: [
      GoRoute(
        path: RouteNames.privacyPolicy,
        name: RouteNames.privacyPolicy,
        builder: (context, state) => UIBannerEnv.banner(
          EnvironmentConfig.current,
          const PrivacyPolicyScreen(mdFileName: 'privacy_policy.md'),
        ),
      ),
      GoRoute(
        path: RouteNames.termCondition,
        name: RouteNames.termCondition,
        builder: (context, state) {
          final isButton = state.extra as bool?;
          return UIBannerEnv.banner(
            EnvironmentConfig.current,
            TermConditionScreen(
              mdFileName: 'term_condition.md',
              isButton: isButton,
            ),
          );
        },
      ),
    ],
  ),
  GoRoute(
    path: RouteNames.landing,
    name: RouteNames.landing,
    builder: (context, state) => const LandingScreen(),
    routes: [
      GoRoute(
        path: RouteNames.privacyPolicyProfile,
        name: RouteNames.privacyPolicyProfile,
        builder: (context, state) => const PrivacyPolicyScreen(
          mdFileName: 'privacy_policy.md',
        ),
      ),
      GoRoute(
        path: RouteNames.termConditionProfile,
        name: RouteNames.termConditionProfile,
        builder: (context, state) => const TermConditionScreen(
          mdFileName: 'term_condition.md',
        ),
      ),
      GoRoute(
        path: RouteNames.statusTransaksi,
        name: RouteNames.statusTransaksi,
        builder: (context, state) => const StatusTransaksiPage(),
      ),
      GoRoute(
        path: RouteNames.phoneFav,
        name: RouteNames.phoneFav,
        builder: (context, state) => const PhoneFavPage(),
      ),
      GoRoute(
        path: RouteNames.rekeningFav,
        name: RouteNames.rekeningFav,
        builder: (context, state) => const RekeningFavPage(),
      ),
      GoRoute(
        path: RouteNames.detailHistory,
        name: RouteNames.detailHistory,
        builder: (context, state) {
          final args = state.extra as DetailTransaksiArg;
          return DetailTransaksiScreen(argument: args);
        },
      ),
      GoRoute(
        path: RouteNames.phone,
        name: RouteNames.phone,
        builder: (context, state) => const PhoneSenderPage(),
        routes: [
          GoRoute(
            path: RouteNames.nominal,
            name: RouteNames.nominal,
            builder: (context, state) => const TopUpCreditPage(),
            routes: [
              GoRoute(
                path: RouteNames.rekening,
                name: RouteNames.rekening,
                builder: (context, state) => const RekeningPage(),
                routes: [
                  GoRoute(
                    path: RouteNames.konfirmasi,
                    name: RouteNames.konfirmasi,
                    builder: (context, state) => const KonfirmasiPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.transfer,
        name: RouteNames.transfer,
        builder: (context, state) => const TransferPage(),
      ),
      GoRoute(
        path: RouteNames.detailTransaction,
        name: RouteNames.detailTransaction,
        builder: (context, state) {
          final args = state.extra as DetailTransaksiArg;
          return DetailTransaksiScreen(argument: args);
        },
      ),
    ],
  ),
  GoRoute(
    path: RouteNames.forceUpdate,
    name: RouteNames.forceUpdate,
    builder: (context, state) => UIBannerEnv.banner(
      EnvironmentConfig.current,
      const ForceUpdateScreen(),
    ),
  ),
];
