import 'package:firebase_auth/firebase_auth.dart';
import 'package:sadaeniswa/Database/blocdata.dart';
import 'package:sadaeniswa/Models/UserModel.dart';
import 'package:sadaeniswa/Resources/auth_rss.dart';

class FirebaseAuthenticationRepository {
  auth_resources _authfirebaseMethods = new auth_resources();
  Bloc _bloc = new Bloc();

  Future<FirebaseUser> getCurrentUser() =>
      _authfirebaseMethods.getCurrentUser();

  Future<FirebaseUser> signIn() => _authfirebaseMethods.signInWithGoogle();

  Future<void> signOut() => _authfirebaseMethods.signOutGoogle();

  Future<bool> authenticateUser(FirebaseUser user) =>
      _authfirebaseMethods.authenticateUser(user);

  Future<void> addDataToDb(FirebaseUser user) =>
      _authfirebaseMethods.addDataToDb(user);

  Future<void> addPostToDb(FirebaseUser user) => _bloc.addPostToDb(user);

  Future<List<UserModel>>  getAllUsersFromDB(FirebaseUser currentUser) => _authfirebaseMethods.getAllUsersFromDB(currentUser);
}
