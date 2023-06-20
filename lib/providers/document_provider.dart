import 'package:file/file.dart';
import 'package:flutter/material.dart';
import 'package:per_note/models/document_model.dart';
import 'package:per_note/repositories/document_repository.dart';

class DocumentProvider extends ChangeNotifier {
  DocumentRepository documentRepository = DocumentRepository();
  static List<DocumentModel> documents = [];

  // get all Document
  Future<List<DocumentModel>> getDocumentsList() async {
    documents = await documentRepository.getAllDocument();
    return documents;
  }


  Future uploadDocument(albumId, List<File> documents) async {
    await documentRepository.uploadDocument(documents);
    notifyListeners();
  }

  Future<Map<String, dynamic>> deleteDocument(String documentsIds) async {
    Map<String, dynamic> result;
    debugPrint(documentsIds);
    result = await documentRepository.deleteDocument(documentsIds);
    //albums.remove(album);
    notifyListeners();
    return result;
  }
}
