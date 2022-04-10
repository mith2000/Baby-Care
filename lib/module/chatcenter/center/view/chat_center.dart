import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';

class ChatCenterView extends StatefulWidget {
  static const routeName = '/chat-center';

  const ChatCenterView({Key key}) : super(key: key);

  @override
  _ChatCenterViewState createState() => _ChatCenterViewState();
}

class _ChatCenterViewState extends State<ChatCenterView> {
  @override
  Widget build(BuildContext context) {
    return Container(color: AppColors.danger);
  }
}
