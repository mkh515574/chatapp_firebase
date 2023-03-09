import 'package:chatapp/bloc/auth_bloc.dart';
import 'package:chatapp/cubit/chat/chat_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../cubit/auth/Login/Login_cubit.dart';

import '../../helper/show_snackBar.dart';
import '../../widget/screen/rl_ui.dart';
import '../home.dart';
import 'Register.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  //TextEditingController email = TextEditingController();
  static String id = "LoginPage";
  TextEditingController pass = TextEditingController();

  TextEditingController email = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  bool isPassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          isLoading = true;
        } else if (state is LoginSuccessState) {

          Navigator.pushNamed(context, HomePage.id, arguments: email.text);
        } else if (state is LoginFailureState) {
          isLoading = false;
          showSnackBar(context, state.errorMassage);
        }
      },
      builder: (context, state) => ModalProgressHUD(
          inAsyncCall: isLoading,
          child: RlUI(
              formKey: formKey,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  BlocProvider.of<AuthBloc>(context).add(
                    LoginEvent(
                      email: email.text,
                      pass: pass.text,
                    ),

                  );
                  email.clear();
                  pass.clear();
                }
              },
              email: email,
              pass: pass,
              isPassword: isPassword,
              pageName: "Login",
              routeName: RegisterPage.id,
              textRoute: "Register")),
    );
  }
}
