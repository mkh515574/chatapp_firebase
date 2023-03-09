import 'package:chatapp/screen/auth/login.dart';
import 'package:chatapp/widget/screen/rl_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


import '../../cubit/auth/register/register_cubit.dart';
import '../../cubit/auth/register/register_states.dart';
import '../../cubit/chat/chat_cubit.dart';
import '../home.dart';


class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  static String id = "RegisterPage";
  TextEditingController pass = TextEditingController();

  TextEditingController email = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isPassword = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          isLoading = true;
        } else if (state is RegisterSuccessState) {
          BlocProvider.of<ChatCubit>(context).getMassages();
          Navigator.pushNamed(context, HomePage.id, arguments: email.text);
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: RlUI(
          formKey: formKey,
          onTap: () {
            if (formKey.currentState!.validate()) {
              BlocProvider.of<RegisterCubit>(context).registerUser(
                  email: email.text, pass: pass.text);
            }
          },
          onPressed: (){
            BlocProvider.of<RegisterCubit>(context).signInWithGoogle();
          },
          email: email,
          pass: pass,
          isPassword: isPassword,
          pageName: "Register",
          textRoute: "Login",
          routeName: LoginPage.id,
        ),
      ),
    );
  }
}

//
// try {
// await registerUser(context);
// Navigator.pushNamed(context, HomePage.id,
// arguments: email.text);
// } on FirebaseAuthException catch (ex) {
// if (ex.code == 'weak-password') {
// showSnackBar(context,
// "The password provided is too weak.");
// } else if (ex.code == 'email-already-in-use') {
// showSnackBar(context,
// "The account already exists for that email.");
// } else if (ex.code == 'invalid-email') {
// showSnackBar(context, "");
// }
// }
