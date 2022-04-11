import 'package:flutter/material.dart';
import 'package:flutter_babycare/utils/app_colors.dart';

import '../../../../utils/app_colors.dart';

class ChatP2PViewArguments {
  final String peerName;

  ChatP2PViewArguments(this.peerName);
}

class ChatP2PView extends StatefulWidget {
  static const routeName = '/chat-p2p';

  const ChatP2PView({Key key}) : super(key: key);

  @override
  _ChatP2PViewState createState() => _ChatP2PViewState();
}

class _ChatP2PViewState extends State<ChatP2PView> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as ChatP2PViewArguments;
    print(args.peerName);
    return Container(color: AppColors.background);
  }
}
