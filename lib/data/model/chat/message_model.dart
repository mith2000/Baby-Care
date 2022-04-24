import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';

class MessageModel {
  String content;
  MessageType type;

  MessageModel({
    @required this.content,
    @required this.type,
  });
}
