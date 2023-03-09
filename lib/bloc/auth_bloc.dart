import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoadingState());
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.pass);

          print(credential.user!.email);
          emit(LoginSuccessState());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
            emit(
              LoginFailureState(errorMassage: "No user found for that email."),
            );
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
            emit(
              LoginFailureState(
                  errorMassage: "Wrong password provided for that user."),
            );
          }
        } catch (e) {
          print(e.toString());
          emit(LoginFailureState(errorMassage: e.toString()));
        }
      }
    });
  }
}
