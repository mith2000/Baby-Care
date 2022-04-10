import 'package:flutter/material.dart';
import '../../../../constants/app_constants.dart';
import '../../../../data/model/baby/baby_model.dart';
import '../../../../data/model/baby/bmi_model.dart';
import '../../../../data/model/baby/ni_model.dart';
import '../../update/view/update_bmi_view.dart';
import '../../update/view/update_food_view.dart';
import '../../../home/bloc/baby_bloc.dart';
import '../../../home/bloc/baby_event.dart';
import '../../../home/bloc/baby_state.dart';
import '../../../meal/view/suggestion_view.dart';
import '../../../../utils/UI_components/baby_status_icon.dart';
import '../../../../utils/UI_components/badge_icon.dart';
import '../../../../utils/UI_components/error_label.dart';
import '../../../../utils/UI_components/highlight_box.dart';
import '../../../../utils/UI_components/icon_button.dart';
import '../../../../utils/UI_components/line_button.dart';
import '../../../../utils/UI_components/loading_widget.dart';
import '../../../../utils/UI_components/solid_button.dart';
import '../../../../utils/UI_components/title_label.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/converter.dart';
import '../../../../utils/evaluate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class BabyDetailViewArguments {
  final BabyModel model;

  BabyDetailViewArguments(this.model);
}

class BabyDetailView extends StatefulWidget {
  static const routeName = '/baby-detail';

  const BabyDetailView({Key key}) : super(key: key);

  @override
  _BabyDetailViewState createState() => _BabyDetailViewState();
}

class _BabyDetailViewState extends State<BabyDetailView> {
  final Map<String, String> _icons = {
    'Carbohydrate': 'assets/icon/carbohydrate.svg',
    'Fat': 'assets/icon/fat.svg',
    'Protein': 'assets/icon/protein.svg',
    'Vitamin A': 'assets/icon/vitamin_a.svg',
    'Vitamin B': 'assets/icon/vitamin_b.svg',
    'Vitamin C': 'assets/icon/vitamin_c.svg',
    'Vitamin D': 'assets/icon/vitamin_d.svg',
    'Iron': 'assets/icon/iron.svg',
    'Calcium': 'assets/icon/calcium.svg',
    'Iodine': 'assets/icon/iodine.svg',
    'info': 'assets/icon/info.svg',
    'achievement': 'assets/icon/achievement.svg',
    'warn': 'assets/icon/warn.svg',
  };
  BabyBloc babyBloc;

  @override
  void initState() {
    super.initState();
    babyBloc = BlocProvider.of<BabyBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as BabyDetailViewArguments;
    babyBloc.add(FetchBMIAndNI(idBaby: args.model.id));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: AppColors.background,
        child: Stack(
          children: [
            ListView(
              children: [
                _buildBabyImage(args),
                Container(
                  child: Column(
                    children: [
                      _buildBabyGeneralInfoFrame(args),
                      SizedBox(height: AppConstants.paddingLargeH),
                      _buildBMIFrame(args),
                      SizedBox(height: AppConstants.paddingLargeH),
                      _buildNIFrame(args),
                      SizedBox(height: AppConstants.paddingNormalH),
                      _buildMealSuggestionButton(args),
                      _buildFeatureButton(
                        featureName: 'Vaccine suggestion',
                        featureDescription:
                            'The following vaccination suggestions are very important for your kid',
                        action: () {},
                        image:
                            AssetImage('assets/image/vaccine_suggestion.jpg'),
                        isRedFrame: true,
                      ),
                      _buildFeatureButton(
                        featureName: 'Vaccination history',
                        featureDescription:
                            'Store vaccination information for your baby',
                        action: () {},
                        image:
                            AssetImage('assets/image/vaccination_history.jpg'),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingLargeW,
                    vertical: AppConstants.paddingNormalH,
                  ),
                ),
                SizedBox(height: AppConstants.paddingSuperLargeH * 2),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildBackButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBabyImage(BabyDetailViewArguments args) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/image/default_baby.png',
      height: ScreenUtil().screenWidth,
      fit: BoxFit.cover,
      image: args.model.image,
    );
  }

  Widget _buildBabyGeneralInfoFrame(BabyDetailViewArguments args) {
    return Column(
      children: [
        Text(
          args.model.name,
          style: Theme.of(context).textTheme.caption,
        ),
        SizedBox(height: AppConstants.paddingLargeH),
        Row(
          children: [
            Text(
              'Baby\'s age:',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(width: AppConstants.paddingNormalW),
            HighlightBox(
              Converter.dateToMonthDouble(
                      DateFormat('dd/MM/yyyy').format(args.model.birth))
                  .toInt()
                  .toString(),
              color: AppColors.primary,
            ),
            SizedBox(width: AppConstants.paddingNormalW),
            Text(
              'months',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Expanded(child: Container()),
            Text(
              'Status',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(width: AppConstants.paddingNormalW),
            BlocBuilder<BabyBloc, BabyState>(
              bloc: babyBloc,
              builder: (context, state) {
                if (state is FoodAndBMILoading) {
                  return CustomLoadingWidget();
                }
                if (state is LoadedBMIAndNI) {
                  if (state.listBMI == null ||
                      state.listBMI.length < 2 ||
                      state.listNI == null ||
                      state.listNI.length < 10) {
                    return ErrorLabel(
                        label:
                            'Something error with your data. We will fix this right now');
                  }
                  BmiModel height;
                  BmiModel weight;
                  if (state.listBMI[0].type == BMIType.Height) {
                    height = state.listBMI[0];
                    weight = state.listBMI[1];
                  } else {
                    height = state.listBMI[1];
                    weight = state.listBMI[0];
                  }

                  List<BabyStatus> statusList = [];
                  statusList.add(Evaluate.heightEvaluate(
                      height.value / 1,
                      Converter.dateToMonthDouble(
                              DateFormat('dd/MM/yyyy').format(args.model.birth))
                          .toInt(),
                      args.model.gender));
                  statusList.add(Evaluate.weightEvaluate(
                      weight.value / 1000,
                      Converter.dateToMonthDouble(
                              DateFormat('dd/MM/yyyy').format(args.model.birth))
                          .toInt(),
                      args.model.gender));
                  for (var nutri in state.listNI) {
                    statusList.add(Evaluate.NIEvaluate(nutri.value));
                  }
                  return BabyStatusIcon(
                      status: Evaluate.AverageEvaluate(statusList));
                }
                return ErrorLabel();
              },
            ),
          ],
        ),
        SizedBox(height: AppConstants.paddingLargeH),
        Container(
          child: Text(
            '15 days left to your baby\'s one month old',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          padding: EdgeInsets.symmetric(
              horizontal: AppConstants.paddingNormalW,
              vertical: AppConstants.paddingNormalH),
          decoration: BoxDecoration(
            color: AppColors.embrace,
            borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 4,
                offset: Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
        ),
        SizedBox(height: AppConstants.paddingLargeH),
        Row(
          children: [
            SvgPicture.asset(_icons['achievement']),
            SizedBox(width: AppConstants.paddingLargeW),
            Text(
              'Next achievement',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(width: AppConstants.paddingNormalW),
            // đỉnk
            // Expanded(Wrap(Container(Text))) thì khi text ngắn sẽ chỉ bao nhỏ, text quá dài sẽ tự có thể xuống dòng
            Expanded(
              child: Wrap(
                children: [
                  Container(
                    child: Text(
                      'Start to walk',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingNormalW,
                        vertical: AppConstants.paddingNormalH),
                    decoration: BoxDecoration(
                      color: AppColors.embrace,
                      borderRadius:
                          BorderRadius.circular(AppConstants.cornerRadius),
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
          ],
        ),
        SizedBox(height: AppConstants.paddingLargeH),
        BlocBuilder<BabyBloc, BabyState>(
            bloc: babyBloc,
            builder: (context, state) {
              if (state is FoodAndBMILoading) {
                return CustomLoadingWidget();
              }
              if (state is LoadedBMIAndNI) {
                if (state.listBMI == null || state.listBMI.length < 2) {
                  return ErrorLabel(
                      label:
                          'Something error with your baby\'s BMI data. We will fix this right now');
                }
                var BMIUpdateDates = <int>[];
                for (var i = 0; i < state.listBMI.length; i++) {
                  BMIUpdateDates.add(Converter.dateToDayDouble(
                          DateFormat('dd/MM/yyyy')
                              .format(state.listBMI[i].updateDate))
                      .toInt());
                }

                int updateDateBMI = 0;
                updateDateBMI = BMIUpdateDates.reduce(
                    (curr, next) => curr < next ? curr : next);

                return Row(
                  children: [
                    updateDateBMI < AppConstants.dateDanger
                        ? SizedBox(width: AppConstants.paddingLargeW * 2)
                        : SvgPicture.asset(_icons['warn']),
                    SizedBox(width: AppConstants.paddingLargeW),
                    Text(
                      'It\'s been',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(width: AppConstants.paddingNormalW),
                    HighlightBox(
                      updateDateBMI.toString(),
                      color: updateDateBMI < AppConstants.dateDanger
                          ? AppColors.primary
                          : AppColors.danger,
                    ),
                    SizedBox(width: AppConstants.paddingNormalW),
                    Text(
                      'days since your last BMI update',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                );
              }
              return ErrorLabel();
            }),
        SizedBox(height: AppConstants.paddingLargeH),
        BlocBuilder<BabyBloc, BabyState>(
            bloc: babyBloc,
            builder: (context, state) {
              if (state is FoodAndBMILoading) {
                return CustomLoadingWidget();
              }
              if (state is LoadedBMIAndNI) {
                if (state.listNI == null || state.listNI.length < 10) {
                  return ErrorLabel(
                      label:
                          'Something error with your baby\'s NI data. We will fix this right now');
                }
                var nutriUpdateDates = <int>[];
                for (var i = 0; i < state.listNI.length; i++) {
                  nutriUpdateDates.add(Converter.dateToDayDouble(
                          DateFormat('dd/MM/yyyy')
                              .format(state.listNI[i].updateDate))
                      .toInt());
                }

                int updateDateNI = 0;
                updateDateNI = nutriUpdateDates
                    .reduce((curr, next) => curr < next ? curr : next);

                return Row(
                  children: [
                    updateDateNI < AppConstants.dateDanger
                        ? SizedBox(width: AppConstants.paddingLargeW * 2)
                        : SvgPicture.asset(_icons['warn']),
                    SizedBox(width: AppConstants.paddingLargeW),
                    Text(
                      'It\'s been',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(width: AppConstants.paddingNormalW),
                    HighlightBox(
                      updateDateNI.toString(),
                      color: updateDateNI < AppConstants.dateDanger
                          ? AppColors.primary
                          : AppColors.danger,
                    ),
                    SizedBox(width: AppConstants.paddingNormalW),
                    Text(
                      'days since your last NI update',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                );
              }
              return ErrorLabel();
            }),
      ],
    );
  }

  Widget _buildBMIFrame(BabyDetailViewArguments args) {
    return BlocBuilder<BabyBloc, BabyState>(
      bloc: babyBloc,
      builder: (context, state) {
        if (state is FoodAndBMILoading) {
          return CustomLoadingWidget();
        }
        if (state is LoadedBMIAndNI) {
          if (state.listBMI == null || state.listBMI.length < 2) {
            return ErrorLabel(
                label:
                    'Something error with your baby\'s BMI data. We will fix this right now');
          }
          BmiModel height;
          BmiModel weight;
          if (state.listBMI[0].type == BMIType.Height) {
            height = state.listBMI[0];
            weight = state.listBMI[1];
          } else {
            height = state.listBMI[1];
            weight = state.listBMI[0];
          }

          return Container(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  child: TitleLabel('Body Mass Index'),
                  padding: EdgeInsets.only(
                    top: AppConstants.paddingLargeH,
                    bottom: AppConstants.paddingNormalH,
                  ),
                ),
                _buildBMIContent(
                  'Current height:',
                  'cm',
                  value: height.value,
                  status: Evaluate.heightEvaluate(
                      height.value / 1,
                      Converter.dateToMonthDouble(
                              DateFormat('dd/MM/yyyy').format(args.model.birth))
                          .toInt(),
                      args.model.gender),
                ),
                _buildBMIContent(
                  'Current weight:',
                  'g',
                  value: weight.value,
                  status: Evaluate.weightEvaluate(
                      weight.value / 1000,
                      Converter.dateToMonthDouble(
                              DateFormat('dd/MM/yyyy').format(args.model.birth))
                          .toInt(),
                      args.model.gender),
                ),
                Container(
                  child: SolidButton('Update', () {
                    Navigator.pushNamed(
                      context,
                      UpdateBMIView.routeName,
                      arguments: UpdateBMIViewArguments(
                        args.model,
                        height,
                        weight,
                      ),
                    );
                  }),
                  padding: EdgeInsets.only(
                    left: AppConstants.paddingLargeW,
                    right: AppConstants.paddingLargeW,
                    top: AppConstants.paddingNormalH,
                    bottom: AppConstants.paddingLargeH,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteBackground,
              borderRadius:
                  BorderRadius.circular(AppConstants.cornerRadiusFrame),
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
        return ErrorLabel();
      },
    );
  }

  Widget _buildBMIContent(
    String label,
    String unit, {
    int value,
    BabyStatus status,
  }) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 40.h,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 111.w),
                  HighlightBox(
                    value.toString() + unit,
                    width: 96,
                    color: AppColors.primary,
                  ),
                  Expanded(child: Container()),
                  BabyStatusIcon(status: status),
                ],
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLargeW,
            vertical: AppConstants.paddingSlightH,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLargeW,
            vertical: AppConstants.paddingNormalH,
          ),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
          ),
        ),
        (status == BabyStatus.Sad || status == BabyStatus.Cry)
            ? BadgeIcon()
            : Container(),
      ],
    );
  }

  Widget _buildNIFrame(BabyDetailViewArguments args) {
    return BlocBuilder<BabyBloc, BabyState>(
        bloc: babyBloc,
        builder: (context, state) {
          if (state is FoodAndBMILoading) {
            return CustomLoadingWidget();
          }
          if (state is LoadedBMIAndNI) {
            if (state.listNI == null || state.listNI.length < 10) {
              return ErrorLabel(
                  label:
                      'Something error with your baby\'s NI data. We will fix this right now');
            }

            NIModel carb,
                fat,
                protein,
                vit_a,
                vit_b,
                vit_c,
                vit_d,
                iron,
                calcium,
                iodine;
            for (var nutri in state.listNI) {
              switch (nutri.type) {
                case NIType.Carbohydrate:
                  carb = nutri;
                  break;
                case NIType.Fat:
                  fat = nutri;
                  break;
                case NIType.Protein:
                  protein = nutri;
                  break;
                case NIType.Vitamin_A:
                  vit_a = nutri;
                  break;
                case NIType.Vitamin_B:
                  vit_b = nutri;
                  break;
                case NIType.Vitamin_C:
                  vit_c = nutri;
                  break;
                case NIType.Vitamin_D:
                  vit_d = nutri;
                  break;
                case NIType.Iron:
                  iron = nutri;
                  break;
                case NIType.Calcium:
                  calcium = nutri;
                  break;
                case NIType.Iodine:
                  iodine = nutri;
                  break;
                default:
                  break;
              }
            }

            return Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    child: TitleLabel('Nutrition Index'),
                    padding: EdgeInsets.only(
                      top: AppConstants.paddingLargeH,
                      bottom: AppConstants.paddingNormalH,
                    ),
                  ),
                  _buildRowOfNI(
                    'Carbohydrate',
                    'Fat',
                    status1: Evaluate.NIEvaluate(carb.value),
                    status2: Evaluate.NIEvaluate(fat.value),
                    infoAction1: () {},
                    infoAction2: () {},
                  ),
                  _buildRowOfNI(
                    'Protein',
                    'Vitamin A',
                    status1: Evaluate.NIEvaluate(protein.value),
                    status2: Evaluate.NIEvaluate(vit_a.value),
                    infoAction1: () {},
                    infoAction2: () {},
                  ),
                  _buildRowOfNI(
                    'Vitamin B',
                    'Vitamin C',
                    status1: Evaluate.NIEvaluate(vit_b.value),
                    status2: Evaluate.NIEvaluate(vit_c.value),
                    infoAction1: () {},
                    infoAction2: () {},
                  ),
                  _buildRowOfNI(
                    'Vitamin D',
                    'Iron',
                    status1: Evaluate.NIEvaluate(vit_d.value),
                    status2: Evaluate.NIEvaluate(iron.value),
                    infoAction1: () {},
                    infoAction2: () {},
                  ),
                  _buildRowOfNI(
                    'Calcium',
                    'Iodine',
                    status1: Evaluate.NIEvaluate(calcium.value),
                    status2: Evaluate.NIEvaluate(iodine.value),
                    infoAction1: () {},
                    infoAction2: () {},
                  ),
                  Container(
                    child: SolidButton('Update', () {
                      Navigator.pushNamed(
                        context,
                        UpdateFoodView.routeName,
                        arguments:
                            UpdateFoodViewArguments(args.model, state.listNI),
                      );
                    }),
                    padding: EdgeInsets.only(
                      left: AppConstants.paddingLargeW,
                      right: AppConstants.paddingLargeW,
                      top: AppConstants.paddingNormalH,
                      bottom: AppConstants.paddingLargeH,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteBackground,
                borderRadius:
                    BorderRadius.circular(AppConstants.cornerRadiusFrame),
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
          return ErrorLabel();
        });
  }

  Widget _buildRowOfNI(
    String nutriName1,
    String nutriName2, {
    BabyStatus status1,
    BabyStatus status2,
    Function infoAction1,
    Function infoAction2,
  }) {
    // bán kính của badge
    final double badgeRadius = 10;
    return Row(
      children: [
        SizedBox(width: badgeRadius.w),
        _buildNIContent(
          nutriName1,
          badgeRadius: badgeRadius,
          status: status1,
          infoAction: infoAction1,
        ),
        _buildNIContent(
          nutriName2,
          badgeRadius: badgeRadius,
          status: status2,
          infoAction: infoAction2,
        ),
      ],
    );
  }

  Widget _buildNIContent(
    String nutriName, {
    double badgeRadius,
    BabyStatus status,
    Function infoAction,
  }) {
    return Stack(
      children: [
        Container(
          width: 167.w,
          height: 164.h,
          child: Column(
            children: [
              SizedBox(height: AppConstants.paddingLargeH),
              SvgPicture.asset(
                _icons[nutriName],
                width: 60.w,
                height: 60.h,
              ),
              SizedBox(height: AppConstants.paddingNormalH),
              Text(
                nutriName,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: AppConstants.paddingNormalH),
              BabyStatusIcon(status: status),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLargeW,
            vertical: AppConstants.paddingSlightH,
          ),
          margin: EdgeInsets.only(
            left: AppConstants.paddingLargeW - badgeRadius.w,
            right: badgeRadius.w,
            top: AppConstants.paddingNormalH,
            bottom: AppConstants.paddingNormalH,
          ),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
          ),
        ),
        (status == BabyStatus.Sad || status == BabyStatus.Cry)
            ? BadgeIcon(xOffset: -(AppConstants.paddingLargeW - badgeRadius.w))
            : Container(),
        Positioned(
          right: AppConstants.paddingSlightW,
          top: AppConstants.paddingSlightH,
          child: CircleIconButton(SvgPicture.asset(_icons['info']), infoAction),
        ),
      ],
    );
  }

  Widget _buildMealSuggestionButton(BabyDetailViewArguments args) {
    return BlocBuilder<BabyBloc, BabyState>(
        bloc: babyBloc,
        builder: (context, state) {
          if (state is FoodAndBMILoading) {
            return CustomLoadingWidget();
          }
          if (state is LoadedBMIAndNI) {
            if (state.listNI == null || state.listNI.length < 10) {
              return ErrorLabel(
                  label:
                      'Something error with your baby\'s NI data. We will fix this right now');
            }
            var nutriDeficiencyList = <NIModel>[];
            for (var i = 0; i < state.listNI.length; i++) {
              if (state.listNI[i].value < 100)
                nutriDeficiencyList.add(state.listNI[i]);
            }

            var nutriUpdateDates = <int>[];
            for (var i = 0; i < state.listNI.length; i++) {
              nutriUpdateDates.add(Converter.dateToDayDouble(
                      DateFormat('dd/MM/yyyy')
                          .format(state.listNI[i].updateDate))
                  .toInt());
            }

            int updateDateNI = 0;
            updateDateNI = nutriUpdateDates
                .reduce((curr, next) => curr < next ? curr : next);

            return _buildFeatureButton(
              featureName: 'Meal suggestion',
              featureDescription:
                  'Get to know what your baby needs for the coming week',
              action: () {
                Navigator.pushNamed(
                  context,
                  MealSuggestionView.routeName,
                  arguments: MealSuggestionViewArguments(
                    args.model,
                    nutriDeficiencyList,
                    updateDateNI,
                  ),
                );
              },
              image: AssetImage('assets/image/meal_suggestion.jpg'),
            );
          }
          return ErrorLabel();
        });
  }

  Widget _buildFeatureButton({
    String featureName,
    String featureDescription,
    Function action,
    ImageProvider image,
    bool isRedFrame = false,
  }) {
    return Container(
      height: 132.h,
      margin: EdgeInsets.symmetric(vertical: AppConstants.paddingNormalH),
      child: ElevatedButton(
        onPressed: action,
        child: Container(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        featureName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24.sp,
                          color: AppColors.whiteBackground,
                        ),
                      ),
                    ),
                    SizedBox(height: AppConstants.paddingNormalH),
                    Container(
                      child: Text(
                        featureDescription,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22.sp,
                          color: AppColors.whiteBackground,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppConstants.paddingNormalW),
              Container(
                height: double.infinity,
                margin: EdgeInsets.only(
                    top: AppConstants.paddingNormalH,
                    bottom: AppConstants.paddingLargeH),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(AppConstants.cornerRadiusFrame),
                  child: Image(
                    width: 100.w,
                    fit: BoxFit.cover,
                    image: image,
                  ),
                ),
              ),
            ],
          ),
          padding: EdgeInsets.only(
            top: AppConstants.paddingNormalH,
            left: AppConstants.paddingLargeW,
            right: AppConstants.paddingLargeW,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isRedFrame == false
                  ? [
                      AppColors.primary,
                      AppColors.secondary,
                    ]
                  : [
                      AppColors.danger,
                      AppColors.highlighter,
                    ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
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
        style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          primary: AppColors.primary,
          onPrimary: AppColors.solidButtonPress,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.cornerRadiusFrame),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingAppW,
        vertical: AppConstants.paddingAppH,
      ),
      child: LineButton('Back', () {
        Navigator.pop(context);
      }),
    );
  }
}
