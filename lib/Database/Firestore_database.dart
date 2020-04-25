

import 'package:cloud_firestore/cloud_firestore.dart';


Firestore firestore = Firestore.instance;
DocumentReference postreference = firestore.collection('posts').document();
DocumentReference userreference = firestore.collection('users').document();
DocumentReference commentReference = firestore.collection('comments').document();
class Repository
{
  Future<QuerySnapshot>  getAllDocuments() async {

    await  Firestore.instance.collection('posts').orderBy('timestamp',descending: true).getDocuments();
  }

  Future<QuerySnapshot> getRequiredDocument(String collectionName,String whereAttribute,String isEqualTo )async {
    return await Firestore.instance.collection(collectionName).where(whereAttribute, isEqualTo: isEqualTo).getDocuments();
  }
  Stream<DocumentSnapshot> getPostData(String documentId) {
    return firestore.collection('posts').document(documentId).snapshots();
  }
  Stream<DocumentSnapshot> getUserData(String documentId) {
    return firestore.collection('users').document(documentId).snapshots();
  }

 Future<void> createPostDocument(Map<String, dynamic> mapPostDocument) async {
  //  await firestore.collection('posts').document().setData(documentReference);
await  postreference.setData(mapPostDocument);
    //await reference.collection('posts').document().setData(mapDoc);
    //print("Posted Data Online");
  }
  Future<void> createUserDocument(Map<String, dynamic> mapUserDocument) async {
    //  await firestore.collection('posts').document().setData(documentReference);
    await  userreference.setData(mapUserDocument);
    //await reference.collection('posts').document().setData(mapDoc);
    //print("Posted Data Online");
  }
  Future<void> createCommentDocument(Map<String,dynamic> mapCommentDocument) async
  {
    await commentReference.setData(mapCommentDocument);
  }
}