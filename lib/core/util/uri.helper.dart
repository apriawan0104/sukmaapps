// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sukmaapps/features/shared/repository/shared.repository.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:io' show Platform;

// import '../core.dart';

// class UriHelper {
//   static Future<void> goUrl({required String url}) async {
//     Uri urlSource = Uri.parse(url);
//     if (!await launchUrl(urlSource)) {
//       throw Exception('Could not launch $urlSource');
//     }
//   }

//   static Future<void> goWhatsapp(
//       {required String body, required WidgetRef ref}) async {
//     try {
//       // Force refresh to always call the endpoint
//       String waNumber = await ref.refresh(getWaNumberRepoProvider.future);

//       // Replace first digit 0 with 62 for international format
//       if (waNumber.startsWith('0')) {
//         waNumber = '62${waNumber.substring(1)}';
//       }

//       Uri url = Uri.parse("https://wa.me/$waNumber?text=$body");
//       if (!await launchUrl(url)) {
//         throw Exception('Could not launch $url');
//       }
//     } catch (e) {
//       // Fallback to environment variable if repository fails
//       Uri url = Uri.parse(
//           "https://wa.me/${dotenv.env[EnvConstant.csPhone]}?text=$body");
//       if (!await launchUrl(url)) {
//         throw Exception('Could not launch $url');
//       }
//     }
//   }

//   static Future<void> goToStore() async {
//     final String url = Platform.isIOS
//         ? dotenv.env[EnvConstant.appStoreUrl] ?? ''
//         : dotenv.env[EnvConstant.playStoreUrl] ?? '';

//     if (url.isEmpty) {
//       return;
//     }

//     final Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     }
//   }
// }
