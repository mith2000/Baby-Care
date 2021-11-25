import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/module/home/bloc/baby_bloc.dart';
import 'package:flutter_babycare/module/home/bloc/baby_state.dart';
import 'package:flutter_babycare/utils/UI_components/mini_line_button.dart';
import 'package:flutter_babycare/utils/UI_components/title_label.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateBabyInfoViewArguments {
  final GenderPick genderPicked;
  final String userId;

  CreateBabyInfoViewArguments(this.genderPicked, this.userId);
}

class CreateBabyInfoView extends StatefulWidget {
  static const routeName = '/create-baby-info';

  const CreateBabyInfoView({Key key}) : super(key: key);

  @override
  _CreateBabyInfoViewState createState() => _CreateBabyInfoViewState();
}

class _CreateBabyInfoViewState extends State<CreateBabyInfoView> {
  Map<String, String> _formData = {
    'name': null,
    'birth': null,
  };
  var _formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  var _birthController = TextEditingController();

  BabyBloc babyBloc;

  var _icons = {
    'user': 'assets/icon/login_user.svg',
    'password': 'assets/icon/login_password.svg',
    'facebook': 'assets/icon/facebook.svg',
    'google': 'assets/icon/google.svg',
  };

  @override
  void initState() {
    super.initState();
    babyBloc = BlocProvider.of<BabyBloc>(context);
    _nameController.addListener(_onNameChange);
    _birthController.addListener(_onBirthChange);
  }

  @override
  void dispose() {
    babyBloc.close();
    _nameController.dispose();
    _birthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments
        as CreateBabyInfoViewArguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<BabyBloc, BabyState>(
        bloc: babyBloc,
        builder: (context, state) {
          return Center(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                color: AppColors.background,
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingAppW,
                  vertical: AppConstants.paddingAppH,
                ),
                child: Form(
                  key: _formKey,
                  child: Stack(
                    children: [
                      Center(
                        child: Wrap(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  TitleLabel('Some basic info of your angel'),
                                  SizedBox(height: AppConstants.paddingLargeH),
                                  _buildNameInput(state),
                                  SizedBox(height: AppConstants.paddingLargeH),
                                  _buildBirthInput(state),
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
                                    offset: Offset(
                                        0, 4), // changes position of shadow
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
                          _buildMainButtons(args),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNameInput(BabyState state) {
    return TextFormField(
      controller: _nameController,
      style: Theme.of(context).textTheme.headline1,
      decoration: InputDecoration(
        hintText: "Baby's name",
        hintStyle: Theme.of(context).textTheme.headline1,
        errorStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          color: AppColors.danger,
        ),
        filled: true,
        fillColor: AppColors.whiteBackground,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
          borderSide: BorderSide(
            width: 1.w,
            color: AppColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
          borderSide: BorderSide(
            width: 1.w,
            color: AppColors.stroke,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
          borderSide: BorderSide(
            width: 1.w,
            color: AppColors.danger,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
          borderSide: BorderSide(
            width: 1.w,
            color: AppColors.danger,
          ),
        ),
      ),
      keyboardType: TextInputType.name,
      onSaved: (String value) {
        _formData['name'] = value;
      },
      validator: (value) {
        if (value.length < 1)
          return "Required";
        // else if (!state.isUsernameValid)
        //   return "Invalid Name";
        else
          return null;
      },
    );
  }

  Widget _buildBirthInput(BabyState state) {
    return TextFormField(
      controller: _birthController,
      style: Theme.of(context).textTheme.headline1,
      decoration: InputDecoration(
        hintText: "dd/MM/yyyy",
        hintStyle: Theme.of(context).textTheme.headline1,
        errorStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          color: AppColors.danger,
        ),
        filled: true,
        fillColor: AppColors.whiteBackground,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
          borderSide: BorderSide(
            width: 1.w,
            color: AppColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
          borderSide: BorderSide(
            width: 1.w,
            color: AppColors.stroke,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
          borderSide: BorderSide(
            width: 1.w,
            color: AppColors.danger,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
          borderSide: BorderSide(
            width: 1.w,
            color: AppColors.danger,
          ),
        ),
      ),
      keyboardType: TextInputType.datetime,
      onSaved: (String value) {
        _formData['birth'] = value;
      },
      validator: (value) {
        if (value.length < 1)
          return "Required";
        // else if (!state.isUsernameValid)
        //   return "Invalid Name";
        else
          return null;
      },
    );
  }

  Widget _buildMainButtons(args) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MiniLineButton('Back', () {
          Navigator.pop(context);
        }),
        SizedBox(width: AppConstants.paddingLargeW),
        _buildNextButton('Next', args),
      ],
    );
  }

  Widget _buildNextButton(String label, args) {
    return Container(
      width: 183.w,
      height: 64.h,
      child: ElevatedButton(
        onPressed: () => _onNextPressed(args),
        child: Text(
          label,
          style: Theme.of(context).textTheme.button,
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          primary: AppColors.primary,
          onPrimary: AppColors.solidButtonPress,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
          ),
        ),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
    );
  }

  void _onNameChange() {
    // todo bloc validate name
    // _registerBloc
    //     .add(RegisterUsernameChanged(username: _nameController.text));
  }

  void _onBirthChange() {
    // todo bloc validate name
    // _registerBloc
    //     .add(RegisterUsernameChanged(username: _nameController.text));
  }

  void _onNextPressed(args) {
    setState(() {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();

      // babyBloc.add(AddedBaby(
      //       babyModel: BabyModel(
      //           name: _nameController.text,
      //           idAccount: args.userId,
      //           birth: _birthController.text,
      //           image:
      //               "https://i.pinimg.com/736x/38/f2/ff/38f2ff0337ea5dbb0ce2e094ca2d910a.jpg"),
      //       userId: args.userId));
    });
  }
}
