import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sadaeniswa/Models/UserModel.dart';
String userdisplayname;
String userid ;
String userEmail;
String userPhotoUrl ;

 class auth_resources
{
  UserModel _user = new UserModel();
  Firestore firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
         final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

if(user.uid!=null)
  {
     userdisplayname = user.displayName ;
     userid = user.uid;
     userEmail= user.email;
     userPhotoUrl=user.photoUrl ;
  }

  return currentUser;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;

  }

  Future<bool> authenticateUser(FirebaseUser user) async {
    QuerySnapshot result = await firestore
        .collection("users")
        .where("email", isEqualTo: user.email)
        .getDocuments();

    final List<DocumentSnapshot> docs = result.documents;

    //if user is registered then length of list > 0 or else less than 0
    return docs.length == 0 ? true : false;
  }

  Future<void> addDataToDb(FirebaseUser currentUser) async {
    //String username = Utils.getUsername(currentUser.email);

    _user = UserModel(
      uid: currentUser.uid,
      email: currentUser.email,
      name: currentUser.displayName,
      profilePhoto: currentUser.photoUrl,
    );

    firestore
        .collection("users")
        .document(currentUser.uid)
        .setData(_user.toMap(_user));

  }
  Future<void> signOutGoogle() async{

      print("Signed Out with Email ID");
      await _auth.signOut();

      await googleSignIn.disconnect();
      return await googleSignIn.signOut();

  }



//----------------------------------------------------------------SignUp/Sign in With Email and Password--------------------------------//

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<FirebaseUser> handleSignInEmail(String email, String password) async {

    AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);

    print('signInEmail succeeded: $user');

    return user;

  }
//-------------------------------------------------------EmailPassword------------------------------------------------//
  Future<void> handleSignUp(email, password) async {

    AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = result.user;

    assert (user != null);
    assert (await user.getIdToken() != null);
    try {
        await user.sendEmailVerification();
    }
    catch (e) {
    print("An error occured while trying to send email verification");
    print(e.message);
    }
return user;


  }




Future<List<UserModel>> getAllUsersFromDB(FirebaseUser currentUser) async
{
List<UserModel> _allUserList = List<UserModel>();
  QuerySnapshot _querySnapshot= await firestore.collection("users").getDocuments();
  for (var i=0; i< _querySnapshot.documents.length;i++)
    {
      if(_querySnapshot.documents[i].documentID != currentUser.uid)
        {
          _allUserList.add(UserModel.fromMap(_querySnapshot.documents[i].data));

        }
    }
  return _allUserList;

}



}






