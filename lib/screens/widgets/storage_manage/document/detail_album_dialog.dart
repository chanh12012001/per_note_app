// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:per_note/models/album_model.dart';
// import 'package:per_note/models/document_model.dart';
// import 'package:per_note/providers/document_provider.dart';
// import 'package:per_note/screens/widgets/widgets.dart';
// import 'package:provider/provider.dart';
// import '../../../../providers/album_provider.dart';
// import '../../../../services/toast_service.dart';

// class DetailDocumentDialog extends StatefulWidget {
//   final DocumentValue? document;
//   const DetailDocumentDialog({
//     Key? key,
//     this.document,
//   }) : super(key: key);

//   @override
//   State<DetailDocumentDialog> createState() => _DetailDocumentDialogState();
// }

// class _DetailDocumentDialogState extends State<DetailDocumentDialog> {
//   ToastService toast = ToastService();
//   bool _loading = false;
//   final TextEditingController _documentNameController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(builder: (context, setState) {
//       return Dialog(
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 20),
//           height: 260,
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 widget.document != null ? 'Cập nhật Document' : "Thêm Document mới",
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 25,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Image.asset(
//                 'assets/images/pattern.png',
//                 height: 20,
//                 width: 200,
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               RoundedInputField(
//                 icon: Icons.photo_album,
//                 hintText: 'Tên document',
//                 onChanged: (value) {
//                   if (widget.document != null) {
//                     widget.document!.name = value;
//                   }
//                 },
//                 controller: widget.document != null
//                     ? TextEditingController(text: widget.document!.name)
//                     : _documentNameController,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               _loading == true
//                   ? const ColorLoader()
//                   : Padding(
//                       padding: const EdgeInsets.only(left: 20, right: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           _buildButton(
//                             text: 'Huỷ bỏ',
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             backgroundColor: Colors.grey,
//                           ),
//                           _buildButton(
//                             text: 'OK',
//                             onPressed: () {
//                               widget.document != null
//                                   ? _updateDocument(widget.document!)
//                                   : _addDocument(_documentNameController.text);
//                               setState(() {
//                                 _loading = true;
//                               });
//                             },
//                             backgroundColor: Colors.teal[300]!,
//                           ),
//                         ],
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   _buildButton(
//       {required String text,
//       required Function onPressed,
//       required Color backgroundColor}) {
//     return ConstrainedBox(
//       constraints: const BoxConstraints.tightFor(width: 100, height: 40),
//       child: ElevatedButton(
//         child: Text(
//           text,
//           style: GoogleFonts.lato(
//             textStyle: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//         onPressed: () {
//           onPressed();
//         },
//         style: ButtonStyle(
//           padding: MaterialStateProperty.all<EdgeInsets>(
//               const EdgeInsets.fromLTRB(20, 3, 20, 3)),
//           backgroundColor: MaterialStateProperty.all(backgroundColor),
//           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   _addDocument(nameDocument) async {
//     DocumentProvider documentProvider =
//         Provider.of<DocumentProvider>(context, listen: false);

//     if (nameDocument == '') {
//       toast.showToast(
//         context: context,
//         message: 'Vui lòng nhập tên tài liệu',
//         icon: Icons.error,
//         backgroundColor: Colors.redAccent,
//       );
//     } else {
//       await documentProvider.createNewDocument(nameDocument);
//       Navigator.pop(context);
//       toast.showToast(
//         context: context,
//         message: 'Thêm thành công',
//         icon: Icons.error,
//         backgroundColor: Colors.green,
//       );
//     }
//     setState(() {
//       _loading = false;
//     });
//   }

//   _updateDocument(DocumentValue document) {
//     DocumentProvider documentProvider =
//         Provider.of<DocumentProvider>(context, listen: false);
//     Map<String, dynamic> params = <String, dynamic>{};
//     params['id'] = document.id;
//     params['name'] = document.name;
//     documentProvider.updateDocument(params).then(
//       (response) {
//         if (response['status']) {
//           Navigator.pop(context);
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

//     setState(() {
//       _loading = false;
//     });
//   }
// }
