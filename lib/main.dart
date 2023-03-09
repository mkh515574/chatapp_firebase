
import 'package:chatapp/bloc/auth_bloc.dart';
import 'package:chatapp/mybloc.dart';
import 'package:chatapp/screen/auth/Register.dart';
import 'package:chatapp/screen/auth/login.dart';
import 'package:chatapp/screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'cubit/auth/Login/Login_cubit.dart';
import 'cubit/auth/register/register_cubit.dart';

import 'cubit/chat/chat_cubit.dart';
import 'firebase_options.dart';
bool? isLogin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();

  var user = FirebaseAuth.instance.currentUser;
  if(user != null ){

    isLogin =true;

  }else{
    isLogin = false;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers:[
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ChatCubit()..getMassages(),
        ),
      ],
      child: MaterialApp(
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) =>  RegisterPage(),
          HomePage.id: (context) => HomePage(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute:isLogin == true ? HomePage.id : LoginPage.id ,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
