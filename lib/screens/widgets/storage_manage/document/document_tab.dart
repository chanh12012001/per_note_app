// import 'package:flutter/material.dart';
// import 'package:per_note/config/theme.dart';
// import 'package:per_note/models/document_model.dart';
// import 'package:per_note/providers/document_provider.dart';
// import 'package:per_note/screens/widgets/loader.dart';
// import 'package:per_note/screens/widgets/storage_manage/document/detail_album_dialog.dart';
// import 'package:per_note/screens/widgets/storage_manage/document/document_list.dart';
// import 'package:per_note/services/toast_service.dart';
// import 'package:provider/provider.dart';

// class DocumentTab extends StatefulWidget {
//   const DocumentTab({Key? key}) : super(key: key);

//   @override
//   State<DocumentTab> createState() => _AlbumTabState();
// }

// class _AlbumTabState extends State<DocumentTab> {
//   ToastService toast = ToastService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: whiteColor,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return const DetailDocumentDialog();
//             },
//           );
//         },
//         backgroundColor: Colors.green,
//         child: const Icon(Icons.add_box),
//       ),
//       body: _showDocuments(),
//     );
//   }

//   _showDocuments() {
//     DocumentProvider documentProvider =
//         Provider.of<DocumentProvider>(context, listen: false);

//     return FutureBuilder<List<DocumentValue>>(
//       future: documentProvider.getDocumentsList(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text("${snapshot.error}");
//         }
//         return snapshot.hasData
//             ? DocumentList(documents: snapshot.data!)
//             : const Center(
//                 child: ColorLoader(),
//               );
//       },
//     );
//   }
// }
