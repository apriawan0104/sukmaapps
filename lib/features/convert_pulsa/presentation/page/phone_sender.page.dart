// import 'package:flutter/material.dart';

// import '../../../../common/common.dart';

// class PhoneSenderPage extends StatelessWidget {
//   const PhoneSenderPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Scaffold(
//         appBar: UIAppBar.appBar(context, title: 'Isi Nomor Pengirim'),
//         body: FutureBuilder(
//           future: Future.wait([ref.watch(getOutstandingProvider.future)]),
//           builder: (context, snapshot) {
//             return Column(
//               children: [
//                 AsyncValueSharedWidget(
//                   value: ref.watch(phoneControllerProvider),
//                   data: (p0) => section(),
//                   onPressed: () {
//                     ref.invalidate(phoneControllerProvider);
//                   },
//                   skipError: true,
//                 ),
//                 const UIKeyPairWidget(),
//                 Expanded(
//                   child: ListView(
//                     children: [
//                       sectionFavorite(),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//         bottomNavigationBar: SafeArea(
//           child: UIButtonBottomWidget(
//             titleButton: 'Lanjutkan',
//             onPressed: () {
//               if (ctrl.phone.isEmpty) {
//                 StaticWidget.msgToast('Pilih No Pengirim terlebih dahulu');
//               } else {
//                 ref.read(goRouterProvider).goNamed(Routes.nominal);
//               }
//             },
//           ),
//         ));
//   }
// }
