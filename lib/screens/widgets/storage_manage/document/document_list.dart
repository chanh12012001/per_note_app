// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:per_note/models/account_model.dart';
// import 'package:per_note/models/document_model.dart';
// import 'package:per_note/screens/widgets/storage_manage/account/account_card.dart';
// import 'package:per_note/screens/widgets/storage_manage/document/document_card.dart';
// import 'package:provider/provider.dart';

// class DocumentList extends StatefulWidget {
//   final List<DocumentValue> documents;

//   const DocumentList({
//     Key? key,
//     required this.documents,
//   }) : super(key: key);

//   @override
//   State<DocumentList> createState() => _DocumentListState();
// }

// class _DocumentListState extends State<DocumentList> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15),
//       child: ListView.builder(
//         itemCount: widget.documents.length,
//         itemBuilder: (context, index) {
//           DocumentValue document = widget.documents[index];
//           return AnimationConfiguration.staggeredList(
//             position: index,
//             child: SlideAnimation(
//               child: FadeInAnimation(
//                 child: GestureDetector(
//                   onTap: () {},
//                   child: DocumentCard(
//                     document: document,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
