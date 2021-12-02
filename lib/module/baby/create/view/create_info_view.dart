import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:flutter_babycare/module/home/bloc/baby_bloc.dart';
import 'package:flutter_babycare/module/home/bloc/baby_event.dart';
import 'package:flutter_babycare/module/home/bloc/baby_state.dart';
import 'package:flutter_babycare/utils/UI_components/icon_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_line_button.dart';
import 'package:flutter_babycare/utils/UI_components/title_label.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_babycare/utils/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'create_bmi_view.dart';

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
  var _formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  var _birthController = TextEditingController();
  var _datePickerController = DateRangePickerController();
  DateTime babyBirth;
  String babyImageUrl;
  bool _isNotifyMust2PickImage = false;

  BabyBloc babyBloc;

  var _icons = {
    'date': 'assets/icon/date.svg',
    'person': 'assets/icon/person.svg',
  };

  @override
  void initState() {
    super.initState();
    babyBloc = BlocProvider.of<BabyBloc>(context);
    _nameController.addListener(_onNameChange);
  }

  @override
  void dispose() {
    babyBloc.close();
    _nameController.dispose();
    _birthController.dispose();
    _datePickerController.dispose();
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
                                  SizedBox(height: AppConstants.paddingLargeH),
                                  _buildImagePicker(args),
                                  _isNotifyMust2PickImage
                                      ? _buildNotifyLable()
                                      : Container()
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
        suffixIcon: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLargeW,
          ),
          child: CircleIconButton(
            SvgPicture.asset(
              _icons['date'],
            ),
            _showDatePicker,
          ),
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
        babyBirth =
            new DateFormat("dd/MM/yyyy hh:mm:ss").parse(value + ' 00:00:00');
      },
      validator: (value) {
        if (value.length < 1)
          return "Required";
        else if (!Validators.isValidDate(value))
          return "Invalid Date";
        else
          return null;
      },
    );
  }

  void _showDatePicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) => Center(
        child: Wrap(
          children: [
            Container(
              child: SfDateRangePicker(
                controller: _datePickerController,
                selectionShape: DateRangePickerSelectionShape.rectangle,
                selectionColor: AppColors.primary,
                minDate: DateTime.now().add(const Duration(days: -365 * 6)),
                maxDate: DateTime.now(),
                headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22.sp,
                    color: AppColors.primary,
                  ),
                ),
                showNavigationArrow: true,
                todayHighlightColor: AppColors.primary,
                monthViewSettings: DateRangePickerMonthViewSettings(
                  firstDayOfWeek: 1,
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: AppColors.text,
                    ),
                  ),
                  dayFormat: 'EEE',
                ),
                showTodayButton: true,
                showActionButtons: true,
                onSubmit: (Object val) {
                  if (val == null) return;
                  babyBirth = val;
                  String datePicked = DateFormat('dd/MM/yyyy').format(val);
                  _birthController.text = datePicked;
                  _datePickerController.selectedDate = null;
                  Navigator.pop(context);
                },
                onCancel: () {
                  _datePickerController.selectedDate = null;
                  Navigator.pop(context);
                },
              ),
              color: AppColors.whiteBackground,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker(CreateBabyInfoViewArguments args) {
    return BlocBuilder<BabyBloc, BabyState>(
        bloc: babyBloc,
        builder: (context, state) {
          if (state is UploadedImageBaby) {
            babyImageUrl = state.urlImage;
            return FadeInImage.assetNetwork(
              placeholder: 'assets/image/default_baby.png',
              height: ScreenUtil().screenWidth,
              fit: BoxFit.cover,
              image: babyImageUrl,
            );
          }
          return CircleIconButton(
            SvgPicture.asset(_icons['person']),
            () async {
              final ImagePicker _imagePicker = ImagePicker();
              XFile _imagePicked =
                  await _imagePicker.pickImage(source: ImageSource.gallery);

              if (_imagePicked == null) return;

              setState(() {
                _isNotifyMust2PickImage = false;
                babyBloc.add(AddImageInFireBase(
                    file: _imagePicked, idAccount: args.userId));
              });
            },
          );
        });
  }

  Widget _buildNotifyLable() {
    return Center(
      child: Text(
        'Must to pick your baby\'s image',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          color: AppColors.danger,
        ),
        textAlign: TextAlign.center,
      ),
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
    babyBloc.add(NameBabyChange(name: _nameController.text));
  }

  void _onNextPressed(CreateBabyInfoViewArguments args) {
    setState(() {
      if (!_formKey.currentState.validate()) {
        return;
      }
      if (babyImageUrl == null) {
        setState(() {
          _isNotifyMust2PickImage = true;
        });
        return;
      }
      _formKey.currentState.save();

      String gender = args.genderPicked == GenderPick.Boy ? "boy" : "girl";

      babyBloc.add(CreateBaby(
        babyModel: BabyModel(
          gender: gender,
          name: _nameController.text,
          idAccount: args.userId,
          birth: babyBirth,
          image: babyImageUrl,
        ),
      ));

      Navigator.pushNamed(
        context,
        CreateBabyBMIView.routeName,
      );
    });
  }
}
