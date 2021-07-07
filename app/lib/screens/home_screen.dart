import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/audible_logo_bw_ko.png"),
        leadingWidth: 110.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 28.0,
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 24.0,
        ),
        child: ListView(
          children: [
            Text(
              'Good afternoon, Brian.',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.0),
            Text(
              'You have 3 credits to spend.',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.grey.shade400),
            ),
            SizedBox(height: 8.0),
            ListTile(
              contentPadding: EdgeInsets.only(left: 0.0),
              title: Text(
                'Continue Listening',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                size: 30.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
