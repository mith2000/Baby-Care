import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:flutter_babycare/data/model/bmi_model.dart';
import 'package:flutter_babycare/module/home/bloc/baby_bloc.dart';
import 'package:flutter_babycare/module/home/bloc/baby_event.dart';
import 'package:flutter_babycare/module/home/bloc/baby_state.dart';
import 'package:flutter_babycare/utils/UI_components/baby_status_icon.dart';
import 'package:flutter_babycare/utils/UI_components/custom_slider.dart';
import 'package:flutter_babycare/utils/UI_components/custom_slider_label.dart';
import 'package:flutter_babycare/utils/UI_components/error_label.dart';
import 'package:flutter_babycare/utils/UI_components/highlight_box.dart';
import 'package:flutter_babycare/utils/UI_components/mini_line_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_solid_button.dart';
import 'package:flutter_babycare/utils/UI_components/title_label.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_babycare/utils/converter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UpdateBMIViewArguments {
  final BabyModel baby;
  final BmiModel height;
  final BmiModel weight;

  UpdateBMIViewArguments(this.baby, this.height, this.weight);
}

class UpdateBMIView extends StatefulWidget {
  static const routeName = '/update-bmi';

  const UpdateBMIView({Key key}) : super(key: key);

  @override
  _UpdateBMIViewState createState() => _UpdateBMIViewState();
}

class _UpdateBMIViewState extends State<UpdateBMIView> {
  Map<String, int> _formData = {
    'height': 0,
    'weight': 0,
  };
  bool _isNotifyMust2Input = false;
  BabyBloc babyBloc;

  @override
  void initState() {
    super.initState();
    babyBloc = BlocProvider.of<BabyBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as UpdateBMIViewArguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            AppConstants.paddingAppH + AppConstants.paddingSuperLargeH),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            height: 32.h,
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(left: AppConstants.paddingAppW),
            child: Text(
              'BMI Update',
              style: GoogleFonts.dosis(
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: AppColors.primary,
          elevation: 0,
        ),
      ),
      body: Center(
        child: Container(
          color: AppColors.background,
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingAppW,
            vertical: AppConstants.paddingAppH,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  _buildBabyInfoView(args),
                  _buildTrackerView(args),
                  _buildInputFrame(),
                ],
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
    );
  }

  Widget _buildBabyInfoView(UpdateBMIViewArguments args, {BabyStatus status}) {
    return Wrap(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 75.w,
              backgroundImage: NetworkImage(args.baby.image),
              backgroundColor: Colors.transparent,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    args.baby.name,
                    style: Theme.of(context).textTheme.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppConstants.paddingNormalH),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Baby\'s age:',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(width: AppConstants.paddingNormalW),
                      HighlightBox(
                        Converter.dateToMonthDouble(DateFormat('dd/MM/yyyy')
                                .format(args.baby.birth))
                            .toInt()
                            .toString(),
                        color: AppColors.primary,
                      ),
                      SizedBox(width: AppConstants.paddingNormalW),
                      Text(
                        'months',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  SizedBox(height: AppConstants.paddingNormalH),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Status',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(width: AppConstants.paddingNormalW),
                      BabyStatusIcon(status: status),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrackerView(
    UpdateBMIViewArguments args,
  ) {
    var BMIUpdateDates = <int>[];
    var BMIlist = [];
    BMIlist.add(args.height);
    BMIlist.add(args.weight);
    for (var i = 0; i < BMIlist.length; i++) {
      BMIUpdateDates.add(Converter.dateToDayDouble(
              DateFormat('dd/MM/yyyy').format(BMIlist[0].updateDate))
          .toInt());
    }

    int updateDateBMI = 0;
    updateDateBMI =
        BMIUpdateDates.reduce((curr, next) => curr < next ? curr : next);

    return Container(
      height: 80.h,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLargeW,
      ),
      margin: EdgeInsets.symmetric(vertical: AppConstants.paddingLargeH),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30.h,
                child: Row(
                  children: [
                    Text(
                      'Last height:',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(width: 19.w),
                    Text(
                      args.height.value.toString() + 'cm',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppConstants.paddingLargeH),
              Container(
                height: 30.h,
                child: Row(
                  children: [
                    Text(
                      'Last weight:',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      args.weight.value.toString() + 'g',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: AppConstants.paddingNormalW),
          Text(
            'since',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(width: AppConstants.paddingNormalW),
          HighlightBox(
            updateDateBMI.toString(),
            color: updateDateBMI <= AppConstants.dateDanger
                ? AppColors.primary
                : AppColors.danger,
          ),
          SizedBox(width: AppConstants.paddingNormalW),
          Text(
            'days ago',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteBackground,
        borderRadius: BorderRadius.circular(AppConstants.cornerRadiusFrame),
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

  Widget _buildInputFrame() {
    return Wrap(
      children: [
        Container(
          child: Column(
            children: [
              TitleLabel('How did your kid grow up?'),
              SizedBox(height: AppConstants.paddingLargeH),
              CustomSliderLabel(
                  label: 'Height: ' +
                      _formData['height'].toString() +
                      'cm ~ ' +
                      (_formData['height'].toDouble() / 100.0).toString() +
                      'm'),
              CustomSlider(
                value: _formData['height'],
                max: 10,
                onChanged: (dynamic values) => {
                  setState(() {
                    _isNotifyMust2Input = false;
                    double valueToInt = values as double;
                    _formData['height'] = valueToInt.round();
                  })
                },
              ),
              SizedBox(height: AppConstants.paddingLargeH),
              CustomSliderLabel(
                  label: 'Weight: ' +
                      _formData['weight'].toString() +
                      '00g ~ ' +
                      (_formData['weight'].toDouble() / 10.0).toString() +
                      'kg'),
              CustomSlider(
                value: _formData['weight'],
                max: 10,
                onChanged: (dynamic values) => {
                  setState(() {
                    _isNotifyMust2Input = false;
                    double valueToInt = values as double;
                    _formData['weight'] = valueToInt.round();
                  })
                },
              ),
              _isNotifyMust2Input ? _buildNotifyLabel() : Container()
            ],
          ),
          margin: EdgeInsets.symmetric(
            horizontal:
                AppConstants.paddingSuperLargeW - AppConstants.paddingAppW,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLargeW,
            vertical: AppConstants.paddingLargeH,
          ),
          decoration: BoxDecoration(
            color: AppColors.whiteBackground,
            borderRadius: BorderRadius.circular(AppConstants.cornerRadiusFrame),
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
    );
  }

  Widget _buildNotifyLabel() {
    return Center(
      child: Text(
        'Must to input increased height or weight',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          color: AppColors.danger,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildMainButtons(
    UpdateBMIViewArguments args,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MiniLineButton('Back', () {
          Navigator.pop(context);
        }),
        SizedBox(width: AppConstants.paddingLargeW),
        BlocBuilder<BabyBloc, BabyState>(
            bloc: babyBloc,
            builder: (context, state) {
              if (state is LoadBMIAndNIBaby) {
                return MiniSolidButton('Save', () {
                  if (_formData['height'] == 0 && _formData['weight'] == 0) {
                    setState(() {
                      _isNotifyMust2Input = true;
                    });
                    return;
                  }

                  babyBloc.add(
                    UpdateBMIEvent(
                      listBmi: [
                        BmiModel(
                            id: args.height.id,
                            idBaby: args.height.idBaby,
                            updateDate: DateTime.now(),
                            type: BMIType.Height,
                            value: args.height.value + _formData['height']),
                        BmiModel(
                            id: args.weight.id,
                            idBaby: args.weight.idBaby,
                            updateDate: DateTime.now(),
                            type: BMIType.Weight,
                            value:
                                args.weight.value + _formData['weight'] * 100),
                      ],
                      idBaby: args.baby.id
                    ),
                  );
                  babyBloc.add(FetchBMIAndNI(idBaby: args.baby.id));
                  Navigator.pop(context);
                });
              }
              return ErrorLabel();
            }),
      ],
    );
  }
}
