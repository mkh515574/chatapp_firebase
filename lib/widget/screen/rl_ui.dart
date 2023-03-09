import 'package:flutter/material.dart';

import '../custom_button.dart';
import '../custom_textfield.dart';

class RlUI extends StatelessWidget {
  RlUI({
    Key? key,
    required this.email,
    required this.pass,
    required this.isPassword,
    required this.pageName,
    required this.routeName,
    required this.textRoute,
    required this.onTap,
    required this.formKey,
    this.onPressed,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;

  bool? isPassword;
  VoidCallback? onPressed;
  final String pageName;
  final String routeName;
  final String textRoute;
  final TextEditingController email;
  final TextEditingController pass;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Container(
                height: size.height * 0.4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.fill),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      height: size.height * 0.2,
                      left: size.width * 0.08,
                      child: Image.asset("assets/images/light-1.png"),
                    ),
                    Positioned(
                      height: size.height * 0.15,
                      left: size.width * 0.35,
                      child: Image.asset("assets/images/light-2.png"),
                    ),
                    Positioned(
                      height: size.height * 0.25,
                      right: size.width * 0.01,
                      child: Image.asset(
                        "assets/images/clock.png",
                      ),
                    ),
                    Positioned(
                        child: Center(
                      child: Text(
                        pageName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(
                        children: <Widget>[
                          CustomTextField(
                            keyboardType: TextInputType.emailAddress,
                            isPassword: isPassword!,
                            textValidate: "Email must be not Empty",
                            controller: email,
                            hintText: "Email or Phone number",
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: !isPassword!,
                            iconData: IconButton(
                                onPressed: () {
                                  isPassword = !isPassword!;
                                },
                                icon: isPassword!
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility)),
                            textValidate: "Password must be not Empty",
                            controller: pass,
                            hintText: 'Password',
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      text: pageName,
                      onTap: onTap,
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1)),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(context, routeName);
                            },
                            child: Text(
                              textRoute,
                              style: const TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, 1)),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("_OR_"),
                    IconButton(
                        onPressed: onPressed,
                        icon: const Icon(Icons.g_mobiledata_outlined,size:80 ,color: Colors.red,),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
