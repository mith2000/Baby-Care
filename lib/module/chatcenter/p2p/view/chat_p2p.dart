import 'package:flutter/material.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/app_constants.dart';
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
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as ChatP2PViewArguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildChatAppbar(args.peerName, args.peerAvatarUrl),
      body: Container(
        color: AppColors.background,
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  color: AppColors.danger,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return SizedBox(
                          height: AppConstants.paddingSuperLargeH * 2);
                    },
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingLargeW,
                  ),
                ),
                SizedBox(height: AppConstants.paddingSuperLargeH * 2),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [],
            )
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
}
