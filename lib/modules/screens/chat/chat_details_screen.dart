import 'package:flutter/material.dart';
import 'package:social_app/models/soical_user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  final SocialUserModel userModel;
  const ChatDetailsScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage('${userModel.image}'),
            ),
            const SizedBox(width: 15.0),
            Text('${userModel.name}'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10.0),
                    topStart: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0),
                  ),
                ),
                child: const Text('Hello World'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
