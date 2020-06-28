import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hackathon_submission/Components/Button.dart';
import 'package:flutter_hackathon_submission/Utils/User.dart';

import '../main.dart';

class AccountPage extends StatelessWidget {
  AccountPage() {
    print(User.user.photoUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(User.user.photoUrl),
              ),
              Container(
                height: 30,
              ),
              Center(
                child: Text(
                  "HI ${User.user.displayName.toUpperCase()}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1.copyWith(color: Theme.of(context).primaryColorLight),
                ),
              )
            ],
          ),
          Button("SIGN OUT", Theme.of(context).primaryColorLight, () {
            User.signOutGoogle().then((value) => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Login())));
          }),
        ],
      ),
    );
  }
}
