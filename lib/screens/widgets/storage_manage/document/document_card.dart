// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:per_note/config/theme.dart';
// import 'package:per_note/models/account_model.dart';
// import 'package:per_note/models/document_model.dart';
// import 'package:per_note/screens/widgets/storage_manage/account/account_add_edit.dart';
// import 'package:per_note/services/toast_service.dart';
// import 'package:provider/provider.dart';

// import '../../../../providers/account_provider.dart';
// import '../../../../providers/loading_provider.dart';
// import '../../alert_dialog.dart';

// class DocumentCard extends StatefulWidget {
//   final DocumentValue document;
//   const DocumentCard({
//     Key? key,
//     required this.document,
//   }) : super(key: key);

//   @override
//   State<DocumentCard> createState() => _DocumentCardState();
// }

// class _DocumentCardState extends State<DocumentCard> {
//   ToastService toast = ToastService();

//   @override
//   Widget build(BuildContext context) {
//     LoadingProvider loadingProvider = Provider.of<LoadingProvider>(context);
//     Size size = MediaQuery.of(context).size;

//     return Slidable(
//       endActionPane: ActionPane(
//         motion: const ScrollMotion(),
//         children: [
//           SlidableAction(
//             onPressed: (context) {
//               loadingProvider.setLoading(false);
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   return MyAlertDialog(
//                     title: 'Warning !!!',
//                     subTitle: 'Bạn có chắc chắn muốn xoá ?',
//                     action: () {
//                       // _deleteAccount(widget.document);
//                     },
//                   );
//                 },
//               );
//             },
//             backgroundColor: redColor!,
//             foregroundColor: Colors.white,
//             icon: Icons.delete,
//             label: 'Xoá',
//           ),
//           SlidableAction(
//             onPressed: (context) {
//               // Navigator.push(context, MaterialPageRoute<void>(
//               //   builder: (BuildContext context) {
//               //     return AddAndEditAccount(
//               //       account: widget.account,
//               //     );
//               //   },
//               // ));
//             },
//             backgroundColor: blueColor!,
//             foregroundColor: Colors.white,
//             icon: Icons.save,
//             label: 'Chỉnh sửa',
//           ),
//         ],
//       ),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 15),
//         width: size.width,
//         decoration: BoxDecoration(
//           color: whiteColor,
//           border: Border.all(color: Colors.grey, width: 0.5),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.grey,
//               blurRadius: 2.0,
//               spreadRadius: 0.0,
//               offset: Offset(0.0, 1.0), // shadow direction: bottom right
//             )
//           ],
//           borderRadius: const BorderRadius.all(Radius.circular(15)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 55,
//                     height: 55,
//                     padding: const EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(100),
//                       color: Theme.of(context).primaryColor.withAlpha(50),
//                     ),
//                     child: const Icon(Icons.account_box),
//                   ),
//                   SizedBox(
//                     width: size.width / 50,
//                   ),
//                   Text(
//                     widget.document.name!,
//                     style: TextStyle(
//                       fontSize: 17,
//                       color: blackColor,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: size.width / 40,
//               ),
//               Text(
//                 widget.document.name!,
//                 style: TextStyle(
//                   color: blackColor,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               // widget.account.note != ''
//               //     ? Text(
//               //         widget.account.note!,
//               //         style: TextStyle(
//               //           fontSize: 14,
//               //           color: blackColor,
//               //         ),
//               //       )
//               //     : Container(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _deleteDocument(Account account) {
//     LoadingProvider loadingProvider =
//         Provider.of<LoadingProvider>(context, listen: false);
//     AccountProvider accountProvider =
//         Provider.of<AccountProvider>(context, listen: false);
//     accountProvider.deleteAccount(account).then(
//       (response) {
//         if (response['status']) {
//           Navigator.pop(context);
//           loadingProvider.setLoading(false);
//           toast.showToast(
//             context: context,
//             message: response['message'],
//             icon: Icons.error,
//             backgroundColor: Colors.green,
//           );
//         } else {
//           toast.showToast(
//             context: context,
//             message: response['message'],
//             icon: Icons.error,
//             backgroundColor: Colors.redAccent,
//           );
//         }
//       },
//     );
//   }
// }
