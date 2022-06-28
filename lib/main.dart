import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant/style/themes.dart';
import 'package:social_app/modules/screens/Layout/cubit/layout_cubit.dart';
import 'package:social_app/modules/screens/Layout/cubit/layout_state.dart';
import 'package:social_app/modules/screens/Layout/layout_screen.dart';
import 'package:social_app/modules/screens/login/login_screen.dart';

import 'constant/Network/Local/cash_helper.dart';
import 'constant/const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.inIt();
  await Firebase.initializeApp();
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = const SocilaLayout();
  } else {
    widget = const LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // for screen
  final Widget startWidget;
  MyApp({
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // the provider
      // and get data from firbase
      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserDate(),
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
