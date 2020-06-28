import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hackathon_submission/Structures/Tip.dart';
import 'package:flutter_hackathon_submission/Utils/User.dart';

class TipCard extends StatelessWidget {
  Tip tip;

  TipCard(this.tip);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(tip.author["photoUrl"]),
          ),
          Container(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        tip.message.toUpperCase(),
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline2.copyWith(color: Theme.of(context).primaryColorDark),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        tip.author["displayName"],
                        style: Theme.of(context).textTheme.bodyText1.copyWith(color: Theme.of(context).primaryColorDark),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      padding: EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            tip.likedBy.contains(User.user.uid)
                                ? EvaIcons.heart
                                : EvaIcons.heartOutline,
                            color: Theme.of(context).primaryColorDark,
                            size: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text(
                              tip.likedBy.length.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      fontSize: 15,
                                      color: Theme.of(context).primaryColorDark),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
