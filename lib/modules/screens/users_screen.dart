import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Users',
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: Colors.grey.shade300,
            ),
      ),
    );
  }
}
