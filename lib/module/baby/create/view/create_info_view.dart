import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:flutter_babycare/module/home/bloc/baby_bloc.dart';
import 'package:flutter_babycare/module/home/bloc/baby_event.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  BabyBloc babyBloc;

  @override
  void initState() {
    super.initState();
    babyBloc = BlocProvider.of<BabyBloc>(context);
  }

  @override
  void dispose() {
    babyBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments
        as CreateBabyInfoViewArguments;
    babyBloc.add(AddedBaby(
        babyModel: BabyModel(
            name: "Duy xinh gai",
            idAccount: args.userId,
            birth: 10,
            image:
                "https://i.pinimg.com/736x/38/f2/ff/38f2ff0337ea5dbb0ce2e094ca2d910a.jpg"),
        userId: args.userId));
    return Container(color: AppColors.background);
  }
}
