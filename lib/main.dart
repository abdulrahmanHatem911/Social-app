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

  // for theme

  bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = const SocilaLayout();
  } else {
    widget = const LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  // for screen
  final Widget startWidget;
  final bool? isDark;
  MyApp({
    required this.startWidget,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // the provider
      // and get data from firebase and get the data about posts
      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialCubit()
            ..getUserDate()
            ..getPosts(),
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.isDark! ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
