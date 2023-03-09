import 'package:chatapp/cubit/auth/register/register_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterLoadingState());

  void registerUser({
    required String email,
    required String pass,
  }) async {
    emit(RegisterLoadingState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) {

            print(value.user);

      emit(RegisterSuccessState());
    }).catchError((e){
      emit(RegisterFailureState());
    });
  }

void signInWithGoogle() async {
    emit(RegisterLoadingState());
    // Trigger the authentication flow
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    ) ;

    // Once signed in, return the UserCredential
   await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
     emit(RegisterSuccessState());
   }).catchError((e){
     print(e.toString());
     emit(RegisterFailureState());
   });
  }
}
