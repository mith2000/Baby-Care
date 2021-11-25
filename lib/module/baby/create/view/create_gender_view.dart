import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/utils/UI_components/icon_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_line_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_solid_button.dart';
import 'package:flutter_babycare/utils/UI_components/title_label.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'create_info_view.dart';

class CreateBabyGenderViewArguments {
  final String userId;

  CreateBabyGenderViewArguments(this.userId);
}

class CreateBabyGenderView extends StatefulWidget {
  static const routeName = '/create-baby-gender';

  const CreateBabyGenderView({Key key}) : super(key: key);

  @override
  _CreateBabyGenderViewState createState() => _CreateBabyGenderViewState();
}

class _CreateBabyGenderViewState extends State<CreateBabyGenderView> {
  GenderPick _genderPick = GenderPick.Unpicked;
  bool _isNotifyMust2Pick = false;
  final Map<String, String> _icons = {
    'boy': 'assets/icon/gender_boy.svg',
    'girl': 'assets/icon/gender_girl.svg',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          color: AppColors.background,
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingAppW,
            vertical: AppConstants.paddingAppH,
          ),
          child: Stack(
            children: [
              Center(
                child: Wrap(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          TitleLabel('What gender is the kid?'),
                          SizedBox(height: AppConstants.paddingLargeH),
                          _buildChooseGenderButtons(),
                          _isNotifyMust2Pick ? _buildNotifyLable() : Container()
                        ],
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingSuperLargeW -
                            AppConstants.paddingAppW,
                        vertical: AppConstants.paddingSuperLargeH -
                            AppConstants.paddingAppH,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingLargeW,
                        vertical: AppConstants.paddingLargeH,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.whiteBackground,
                        borderRadius: BorderRadius.circular(
                            AppConstants.cornerRadiusFrame),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 4,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildMainButtons(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotifyLable() {
    return Center(
      child: Text(
        'Must to pick 1 of 2',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          color: AppColors.danger,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildChooseGenderButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildGenderOption(
          _genderPick == GenderPick.Boy,
          _icons['boy'],
          () {
            setState(() {
              _genderPick = GenderPick.Boy;
              _isNotifyMust2Pick = false;
            });
          },
        ),
        SizedBox(width: AppConstants.paddingLargeW * 2),
        _buildGenderOption(
          _genderPick == GenderPick.Girl,
          _icons['girl'],
          () {
            setState(() {
              _genderPick = GenderPick.Girl;
              _isNotifyMust2Pick = false;
            });
          },
        ),
      ],
    );
  }

  Widget _buildGenderOption(
    bool statement,
    String assetName,
    Function action,
  ) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        statement
            ? Container(
                width: 110.w,
                height: 110.h,
                child: Container(),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
              )
            : Container(),
        CircleIconButton(
          Container(
            width: 100.w,
            height: 100.h,
            child: SvgPicture.asset(
              assetName,
              fit: BoxFit.none,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.background,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 4,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
          ),
          action,
        ),
      ],
    );
  }

  Widget _buildMainButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MiniLineButton('Back', () {
          Navigator.pop(context);
        }),
        SizedBox(width: AppConstants.paddingLargeW),
        MiniSolidButton('Next', () {
          if (_genderPick == GenderPick.Unpicked) {
            setState(() {
              _isNotifyMust2Pick = true;
            });
            return;
          }
          final args = ModalRoute.of(context).settings.arguments
              as CreateBabyGenderViewArguments;
          Navigator.pushNamed(
            context,
            CreateBabyInfoView.routeName,
            arguments: CreateBabyInfoViewArguments(_genderPick, args.userId),
          );
        }),
      ],
    );
  }
}
