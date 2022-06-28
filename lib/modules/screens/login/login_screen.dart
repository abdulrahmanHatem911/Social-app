import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant/const.dart';
import 'package:social_app/modules/screens/Layout/layout_screen.dart';
import 'package:social_app/modules/screens/login/cubit/loginCubit.dart';
import 'package:social_app/modules/screens/login/cubit/loginState.dart';
import 'package:social_app/modules/screens/regester/regester_screen.dart';

import '../../../constant/Network/Local/cash_helper.dart';

// ده بيكون علشات الفورم
var formKey = GlobalKey<FormState>();
// الكونتينير الخاص ببالبسورد و الايمااال
var emailController = TextEditingController();
var passowrdController = TextEditingController();

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          // whensussess loading to the app
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              showToast(
                text: 'Success Login to app',
                state: ToastStates.SUCSSES,
              );
              navigateAndFinash(
                context,
                const SocilaLayout(),
              );
            });
          }
        },
        builder: (context, state) {
          SocialLoginCubit cubit = SocialLoginCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          Text(
                            'Login now to communicate with friendies',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                      fontSize: 16.0,
                                    ),
                          ),
                          const SizedBox(height: 30.0),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'enter your email',
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter youre email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15.0),
                          TextFormField(
                            controller: passowrdController,
                            obscureText: cubit.isPassword,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'enter your password',
                              prefixIcon:
                                  const Icon(Icons.lock_outline_rounded),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  cubit.changePasswordVisibility();
                                },
                                icon: (Icon(cubit.suffix)),
                              ),
                              border: const OutlineInputBorder(),
                            ),
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                // SocialLoginCubit.get(context).userLogin(
                                //   email: emailController.text,
                                //   password: passowrdController.text,
                                // );
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is to short ';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15.0),
                          ConditionalBuilder(
                            condition: state is! SocialLoginLoadingState,
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            builder: (context) => Container(
                              width: double.infinity,
                              color: Colors.blue,
                              child: MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passowrdController.text,
                                    );
                                  }
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don'nt have acount "),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, RegesterScreen());
                                  },
                                  child: const Text('Regester'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
