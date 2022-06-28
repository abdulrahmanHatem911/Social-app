import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant/const.dart';
import 'package:social_app/constant/style/icon_broken.dart';
import 'package:social_app/modules/screens/Layout/cubit/layout_cubit.dart';
import 'package:social_app/modules/screens/Layout/cubit/layout_state.dart';
import 'package:social_app/modules/screens/new_post_screen.dart';

class SocilaLayout extends StatelessWidget {
  const SocilaLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostNavState) {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var model = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Search),
              ),
            ],
            title: Text(
              cubit.titlsScreen[cubit.currentIndex],
            ),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chats',
              ),
              // new post
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Paper_Upload),
                label: 'Posts',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Location),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
