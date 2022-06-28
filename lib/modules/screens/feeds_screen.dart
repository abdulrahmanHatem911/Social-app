import 'package:flutter/material.dart';
import 'package:social_app/constant/style/color.dart';
import 'package:social_app/constant/style/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10.0,
            margin: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                const Image(
                  image: NetworkImage(
                      'https://i.pinimg.com/564x/22/95/1d/22951db4c4a6b4bbecd4a491ba23394d.jpg'),
                  fit: BoxFit.cover,
                  height: 150.0,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Commmictaa flose sdffwe sdfasdasd',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return builtPostItem(context);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8.0),
            itemCount: 15,
          ),
        ],
      ),
    );
  }

  Widget builtPostItem(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/564x/af/7a/1a/af7a1ac8729932ec8f8dccfcb3288fa0.jpg'),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Abdulrahman ',
                            style: TextStyle(
                              height: 1.4,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(width: 7.0),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 14.0,
                          )
                        ],
                      ),
                      Text(
                        'Abdulrahman hhsdfasfiweef',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15.0),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                ),
              ],
            ),
            // the line
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: double.infinity,
                height: 1.3,
                color: Colors.grey[300],
              ),
            ),
            Text(
              'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isnt anything embarrassing hidden in the middle of text.',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    // الهشتاج
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 7.0,
                      ),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#softwar',
                            style: TextStyle(
                              color: Colors.blue[600],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 7.0,
                      ),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#softwar',
                            style: TextStyle(
                              color: Colors.blue[600],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 7.0,
                      ),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#softwar',
                            style: TextStyle(
                              color: Colors.blue[600],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 150.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://i.pinimg.com/564x/49/cb/e2/49cbe24f4e7ee3321aac1e40011303d6.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  // for like
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              '1234',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // for commint
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              '12o commint ',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //the line two
            Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.3,
                color: Colors.grey[300],
              ),
            ),
            // the write commint
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage(
                              'https://i.pinimg.com/564x/af/7a/1a/af7a1ac8729932ec8f8dccfcb3288fa0.jpg'),
                        ),
                        const SizedBox(width: 20.0),
                        Text(
                          'Write comment ....',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 14.0,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        '1234',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
