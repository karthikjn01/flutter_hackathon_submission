import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseUser user;
  static User u;

  static Future<int> login() async {
    FirebaseUser user = await _auth.currentUser();
    if (user == null) {
      return 0;
    } else {
      DocumentSnapshot ds =
          await Firestore.instance.collection("user").document(user.uid).get();

      if (User.user == null) {
        User.user = user;
      }
      return 1;
    }

    return 0;
  }

  static Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
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

    User.user = currentUser;

    DocumentSnapshot ds =
        await Firestore.instance.collection("user").document(user.uid).get();
    if (ds.data != null) {
    } else {}

    return user;
  }

  static void signOutGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();

    user = null;
    u = null;

    print("User Sign Out");
  }
}
