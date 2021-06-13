import 'package:Seller_App/providers/notification.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayButton extends StatefulWidget {
  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Messages>(builder: (context, Messages msg, child) {
      if (msg.messagesList.length == 0 || msg.isRead) {
        return Container();
      }
      return AvatarGlow(
        startDelay: Duration(milliseconds: 1000),
        glowColor: Colors.red,
        endRadius: 20.0,
        duration: Duration(milliseconds: 2000),
        showTwoGlows: true,
        repeatPauseDuration: Duration(milliseconds: 100),
        repeat: true,
        child: Container(
          height: 16,
          width: 16,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            msg.unreadCount.toString(),
            style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFF7557D6)),
          ),
        ),
      );
    });
  }
}
