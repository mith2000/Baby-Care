// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:flutter_babycare/data/model/bmi_model.dart';
import 'package:flutter_babycare/data/model/food_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class BabyEvent extends Equatable {
  final BabyModel babyModel;
  final String userId;

  const BabyEvent({this.babyModel, this.userId});

  @override
  List<Object> get props => [];
}

class LoadBaby extends BabyEvent {
  final String userId;

  LoadBaby({this.userId}) : super();

  @override
  List<Object> get props => [userId];
}

class LoadBMI extends BabyEvent {
  final String idBaby;

  LoadBMI({this.idBaby});

  @override
  List<Object> get props => [idBaby];
}

class CreateBMI extends BabyEvent {
  final List<BmiModel> listBMIModel;

  CreateBMI({this.listBMIModel});

  @override
  List<Object> get props => [listBMIModel];
}

class CreateBaby extends BabyEvent {
  final BabyModel babyModel;

  const CreateBaby({this.babyModel}) : super();

  @override
  List<Object> get props => [this.babyModel];
}

class UpdateBMI extends BabyEvent {
  final String idBaby;
  final List<BmiModel> listBmi;

  UpdateBMI({this.idBaby, this.listBmi});

  @override
  List<Object> get props => [listBmi];
}

class UpdateFood extends BabyEvent {
  final String idBaby;
  final List<FoodModel> listFood;

  UpdateFood({this.idBaby, this.listFood});

  @override
  List<Object> get props => [listFood];
}

class NameBabyChange extends BabyEvent {
  final String name;

  const NameBabyChange({this.name});

  @override
  List<Object> get props => [name];
}

class AddedImage extends BabyEvent {
  final String urlImage;

  const AddedImage({this.urlImage});

  @override
  List<Object> get props => [urlImage];
}

class AddImageInFireBase extends BabyEvent {
  final XFile file;
  final String idAccount;

  const AddImageInFireBase({this.file, this.idAccount}) : super();

  @override
  List<Object> get props => [file];
}

class BirthBabyChange extends BabyEvent {
  final double birth;

  const BirthBabyChange({this.birth});

  @override
  List<Object> get props => [birth];
}

class UpdateBaby extends BabyEvent {
  final BabyModel babyModel;
  UpdateBaby({this.babyModel});

  @override
  List<Object> get props => [babyModel];

  @override
  String toString() => 'BabyUpdated';
}

class CreateFood extends BabyEvent {
  final List<FoodModel> listFoodModel;

  const CreateFood({this.listFoodModel}) : super();

  @override
  List<Object> get props => [listFoodModel];
}

class FetchFood extends BabyEvent {
  final String idBaby;
  final int dayAgo;

  FetchFood({this.idBaby, this.dayAgo});

  @override
  List<Object> get props => [idBaby];
}

class FetchNI extends BabyEvent {
  final String idBaby;

  FetchNI({this.idBaby});

  @override
  List<Object> get props => [idBaby];
}

class FetchBMIAndNI extends BabyEvent {
  final String idBaby;

  FetchBMIAndNI({this.idBaby});

  @override
  List<Object> get props => [idBaby];
}
