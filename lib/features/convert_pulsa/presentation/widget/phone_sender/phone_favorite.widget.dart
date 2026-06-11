// import 'package:flutter/material.dart';

// class PhoneFavoriteWidget extends StatelessWidget {
//   const PhoneFavoriteWidget({super.key, required this.ctrl});
//   final ConvertPulsaController ctrl;
//   @override
//   Widget build(BuildContext context) {
//     final ctrl = ref.watch(phoneControllerProvider.notifier);
//     return RPadding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Nomor Favorit',
//             style: GoogleFonts.plusJakartaSans(
//               color: const Color(0xFF101828),
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           SizedBox(height: 4.h),
//           AsyncValueSharedWidget(
//             value: ref.watch(getListPhoneFavProvider),
//             data: (p0) {
//               if (p0.isNotEmpty) {
//                 return Column(
//                   children: List.generate(
//                     p0.length,
//                     (index) => cardFavorite(
//                       namaProvider: p0[index].provider!,
//                       nomor: p0[index].number!,
//                       id: p0[index].id!,
//                       providerid: p0[index].providerId!,
//                       rate: p0[index].rate!,
//                       providerMinConv: p0[index].minConvert ?? 0,
//                       providerMaxConv: p0[index].maksConvert ?? 0,
//                       index: index,
//                     ),
//                   ),
//                 );
//               } else {
//                 return cardEmptyFavorite();
//               }
//             },
//             onPressed: () {
//               ctrl.refreshNoFav();
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
