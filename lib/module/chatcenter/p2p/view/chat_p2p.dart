import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babycare/utils/UI_components/own_message_card.dart';
import 'package:flutter_babycare/utils/UI_components/reply_message_card.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/app_constants.dart';
import '../../../../data/model/chat/message_model.dart';
import '../../../../utils/UI_components/icon_button.dart';
import '../../../../utils/app_colors.dart';

class ChatP2PViewArguments {
  final String peerName;
  final String peerAvatarUrl;

  ChatP2PViewArguments(this.peerName, this.peerAvatarUrl);
}

class ChatP2PView extends StatefulWidget {
  static const routeName = '/chat-p2p';

  const ChatP2PView({Key key}) : super(key: key);

  @override
  _ChatP2PViewState createState() => _ChatP2PViewState();
}

class _ChatP2PViewState extends State<ChatP2PView> {
  Map<String, String> _formData = {
    'content': null,
  };
  var _formKey = GlobalKey<FormState>();
  var _textController = TextEditingController();
  var _scrollController = ScrollController();
  bool _hasText = false;

  List<MessageModel> _messages = [];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as ChatP2PViewArguments;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildChatAppbar(args.peerName, args.peerAvatarUrl),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: AppConstants.paddingAppW),
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _messages[index].type == MessageTypes.Own
                        ? OwnMessageCard(_messages[index].content)
                        : ReplyMessageCard(_messages[index].content);
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [_buildTextInput()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatAppbar(String title, String avatarUrl) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
          AppConstants.paddingAppH + AppConstants.paddingSuperLargeH),
      child: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Container(
          margin: EdgeInsets.only(left: AppConstants.paddingNormalW),
          child: Row(
            children: [
              CircleIconButton(
                SvgPicture.asset('assets/icon/arrow_back.svg'),
                () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                  width:
                      AppConstants.paddingLargeW + AppConstants.paddingNormalW),
              CircleAvatar(
                radius: 20.w,
                backgroundColor: AppColors.whiteBackground,
                child: avatarUrl == null
                    ? CircleAvatar(
                        radius: 20.w,
                        backgroundImage:
                            AssetImage('assets/image/logo_s150.png'),
                      )
                    : CircleAvatar(
                        radius: 20.w,
                        backgroundImage: NetworkImage(avatarUrl),
                      ),
              ),
              SizedBox(width: AppConstants.paddingLargeW),
              Text(
                title,
                style: GoogleFonts.dosis(
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
    );
  }

  Widget _buildTextInput() {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.all(
          AppConstants.paddingLargeW,
        ),
        child: TextFormField(
          controller: _textController,
          style: Theme.of(context).textTheme.headline1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: AppConstants.paddingLargeW,
              top: AppConstants.paddingNormalH,
              bottom: AppConstants.paddingNormalH,
            ),
            hintText: "Chatting...",
            hintStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22.sp,
              color: AppColors.stroke,
            ),
            suffixIcon: CircleIconButton(
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingLargeW,
                  vertical: AppConstants.paddingNormalH,
                ),
                child: _hasText
                    ? SvgPicture.asset('assets/icon/send.svg')
                    : SvgPicture.asset('assets/icon/send_inactive.svg'),
              ),
              () {
                if (_hasText) _onSendPressed();
              },
            ),
            filled: true,
            fillColor: AppColors.whiteBackground,
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppConstants.cornerRadiusFrame),
              borderSide: BorderSide(
                width: 1.w,
                color: AppColors.primary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppConstants.cornerRadiusFrame),
              borderSide: BorderSide(
                width: 1.w,
                color: AppColors.stroke,
              ),
            ),
          ),
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 5,
          onChanged: (value) {
            if (value.length > 0) {
              setState(() {
                _hasText = true;
              });
            } else {
              setState(() {
                _hasText = false;
              });
            }
          },
          onSaved: (String value) {
            _formData['content'] = value.trim();
          },
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.cornerRadiusFrame),
        ),
      ),
    );
  }

  void _onSendPressed() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);

      _setMessage(MessageTypes.Own, _formData['content']);
      _setMessage(MessageTypes.Other, "...");
      _sendMessageToServer(_formData['content']);

      _textController.clear();
      _hasText = false;
    });
  }

  void _sendMessageToServer(String message) async {
    Message response = await _getMessageResponse(_formData['content']);
    setState(() {
      _messages.removeLast();
    });
    if (response != null) {
      response.payload['messages']
          .forEach((item) => _setMessage(MessageTypes.Other, item.toString()));
    } else {
      _setMessage(MessageTypes.Other,
          "An error has occurred on the server.\nPlease try again.");
    }
  }

  void _setMessage(MessageTypes type, String content) {
    MessageModel messageModel = MessageModel(type: type, content: content);
    print(messageModel.content);

    setState(() {
      _messages.add(messageModel);
    });
  }

  Future<Message> _getMessageResponse(String text) async {
    DialogFlowtter dialogFlowtter;
    DialogAuthCredentials credentials;
    credentials = await DialogAuthCredentials.fromFile(
        'assets/babycare-caug-5734d56d8adc.json');
    dialogFlowtter = DialogFlowtter(
      credentials: credentials,
      sessionId: "babycare-caug",
    );
    final QueryInput queryInput = QueryInput(
      text: TextInput(
        text: text,
        languageCode: "en",
      ),
    );
    DetectIntentResponse response;
    try {
      response = await dialogFlowtter.detectIntent(
        queryInput: queryInput,
      );
      return response.message;
    } catch (error) {
      return new Message(payload: {"Nah~\nTry another question please": ""});
    }
  }
}
