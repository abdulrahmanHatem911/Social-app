import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant/const.dart';
import 'package:social_app/modules/screens/Layout/layout_screen.dart';
import 'package:social_app/modules/screens/regester/cubit/login_cubit.dart';
import 'package:social_app/modules/screens/regester/cubit/login_state.dart';

class RegesterScreen extends StatelessWidget {
  //containers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passowrdController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            // after sucsses create new user
            // go to layout screen
            navigateAndFinash(
              context,
              const SocilaLayout(),
            );
          }
        },
        builder: (context, state) {
          SocialRegisterCubit cubit = SocialRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
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
                            'REGESTER',
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          Text(
                            'Regester now to communicate with friendies',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                      fontSize: 16.0,
                                    ),
                          ),
                          const SizedBox(height: 30.0),

                          // FOR NAME

                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              hintText: 'name your email',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter youre name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15.0),
                          // FOR EMAIL

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

                          // FOR PASSWORD !!

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
                                icon: (Icon(
                                  cubit.suffix,
                                )),
                              ),
                              border: const OutlineInputBorder(),
                            ),
                            onFieldSubmitted: (value) {
                              // if (formKey.currentState!.validate()) {
                              //   SocialRegisterCubit.get(context).userLogin(
                              //     email: emailController.text,
                              //     password: passowrdController.text,
                              //   );
                              // }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is to short ';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15.0),

                          // FOE PHONE NUMBER ): !!

                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Phone',
                              hintText: 'name your phone',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter youre phone ';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15.0),

                          ConditionalBuilder(
                            condition: state is! SocialRegisterLoadingState,
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            builder: (context) => Container(
                              width: double.infinity,
                              color: Colors.blue,
                              child: MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialRegisterCubit.get(context)
                                        .userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passowrdController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                child: const Text(
                                  'REGESITER',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
