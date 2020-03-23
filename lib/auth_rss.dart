


import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

 class auth_resources
{


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
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
    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async{
    await googleSignIn.signOut();

    print("User Sign Out");
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
  Future<FirebaseUser> handleSignUp(email, password) async {

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

}

class Authenticate_Email_Password
{

}






