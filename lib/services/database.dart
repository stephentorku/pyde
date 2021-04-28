import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pyde/models/cause.dart';
import 'package:pyde/models/user.dart';

class DatabaseService {
  final CollectionReference causeCollection =
      FirebaseFirestore.instance.collection('cause');

  final String uid;

  DatabaseService({this.uid});

  Future<void> createCause(
      String title,
      String starter,
      String description,
      String email,
      int target,
      int amountRaised,
      String access,
      String created) async {
    return await causeCollection.doc(uid).set({
      'title': title,
      'starter': starter,
      'description': description,
      'email': email,
      'target': target,
      'amountRaised': amountRaised,
      'access': access,
      'created': created,
      'searchID': uid,
      'notified': 'n'
    });
  }

  //cause list from snapshot
  List<Cause> _causeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Cause(
        title: doc.data()['title'] ?? '',
        starter: doc.data()['starter'] ?? 'default',
        email: doc.data()['email'] ?? '',
        created: doc.data()['created'] ?? null,
        searchID: doc.data()['searchID'] ?? 'default',
        access: doc.data()['access'] ?? 'public',
      );
    }).toList();
  }

  Stream<List<Cause>> get causes {
    return causeCollection.snapshots().map(_causeListFromSnapshot);
  }
}

//class to get details
class DetailsService {
  final CollectionReference causeCollection =
      FirebaseFirestore.instance.collection('cause');
  String searchID;
  DetailsService({this.searchID});

  CauseData _causeDataFromSnapshot(DocumentSnapshot snapshot) {
    return CauseData(
        title: snapshot.data()['title'],
        starter: snapshot.data()['starter'],
        description: snapshot.data()['description'],
        email: snapshot.data()['email'],
        target: snapshot.data()['target'],
        currentAmount: snapshot.data()['amountRaised'],
        access: snapshot.data()['access'],
        created: snapshot.data()['created'],
        searchID: snapshot.data()['searchID']);
  }

  CauseData _getAmountRaisedFromSnapShot(DocumentSnapshot snapshot) {
    return CauseData(currentAmount: snapshot.data()['amountRaised']);
  }

  CauseData _getEmailDetailsFromSnapshot(DocumentSnapshot snapshot) {
    return CauseData(
      currentAmount: snapshot.data()['amountRaised'],
      email: snapshot.data()['email'],
      target: snapshot.data()['target'],
      notified: snapshot.data()['notified'],
      starter: snapshot.data()['starter'],
      title: snapshot.data()['title'],
    );
  }

  Stream<CauseData> get emailDetails {
    return causeCollection
        .doc(searchID)
        .snapshots()
        .map(_getEmailDetailsFromSnapshot);
  }

  Stream<CauseData> get amountRaised {
    return causeCollection
        .doc(searchID)
        .snapshots()
        .map(_getAmountRaisedFromSnapShot);
  }

  Stream<CauseData> get causeData {
    return causeCollection
        .doc(searchID)
        .snapshots()
        .map(_causeDataFromSnapshot);
  }

  Future<void> updateCauseAmountRaised(
    int newAmount,
  ) async {
    return await causeCollection.doc(searchID).update({
      'amountRaised': newAmount,
    });
  }

  Future<void> updateNotifiedStatus(
    String status,
  ) async {
    return await causeCollection.doc(searchID).update({
      'notified': status,
    });
  }

  Future<void> updateEditDetails(String title, String starter,
      String description, int target, String email, String access) async {
    return await causeCollection.doc(searchID).update({
      'title': title,
      'starter': starter,
      'description': description,
      'target': target,
      'email': email,
      'access': access,
    });
  }

  Future<void> deleteCause() async {
    return await causeCollection.doc(searchID).delete();
  }
}
