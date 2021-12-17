// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:flutter_babycare/data/model/bmi_model.dart';
import 'package:flutter_babycare/data/model/food_model.dart';
import 'package:flutter_babycare/data/model/ni_model.dart';

class BabyState extends Equatable {
  final bool isNameValid;
  final bool isBirthValid;
  final List<BabyModel> listBaby;
  final List<BmiModel> listBMI;
  final List<NIModel> listNI;

  BabyState(
      {this.isNameValid,
      this.isBirthValid,
      this.listBaby,
      this.listBMI,
      this.listNI});

  @override
  List<Object> get props => [];

  BabyState updateListBMIAndNI({List<BmiModel> listBMI, List<NIModel> listNI}) {
    return BabyState(
        listBMI: listBMI == null ? this.listBMI : listBMI,
        listNI: listNI == null ? this.listNI : listNI);
  }

  BabyState update({
    bool isNameValid,
    bool isBirthValid,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isBirthValid: isBirthValid,
    );
  }

  BabyState copyWith({
    bool isNameValid,
    bool isBirthValid,
  }) {
    return BabyState(
      isNameValid: isNameValid ?? this.isNameValid,
      isBirthValid: isBirthValid ?? this.isBirthValid,
    );
  }
}

class UploadedImageBaby extends BabyState {
  final String urlImage;

  UploadedImageBaby([this.urlImage]);

  @override
  List<Object> get props => [urlImage];

  @override
  String toString() => 'Upload image success { urlImage: $urlImage }';
}

class LoadBMIBaby extends BabyState {
  final List<BmiModel> list;

  LoadBMIBaby({this.list});

  @override
  List<Object> get props => [list];
}

class LoadFoodBaby extends BabyState {
  final List<FoodModel> list;

  LoadFoodBaby({this.list});

  @override
  List<Object> get props => [list];
}

class LoadNIBaby extends BabyState {
  final List<NIModel> list;

  LoadNIBaby({this.list});

  @override
  List<Object> get props => [list];
}

class LoadBMIAndNIBaby extends BabyState {
  final List<NIModel> listNI;
  final List<BmiModel> listBMI;
  int countNI;
  int countBMI;

  LoadBMIAndNIBaby({this.listNI, this.listBMI}) {
    countNI = listNI.length;
    countBMI = listBMI.length;
  }

  @override
  List<Object> get props => [listNI, listBMI];

  @override
  String toString() =>
      'FetchedBMIAndNI { LenghtNI: $countNI ,LenghtBMI:  $countBMI}';
}

class BabyCreated extends BabyState {
  final String idBaby;

  BabyCreated({this.idBaby});

  @override
  List<Object> get props => [idBaby];
}

class BabyLoading extends BabyState {}

class ImageLoading extends BabyState {}

class FoodLoading extends BabyState {}

class FoodAndBMILoading extends BabyState {}

class NILoading extends BabyState {}

class BabyLoaded extends BabyState {
  final List<BabyModel> listBaby;
  int count;

  BabyLoaded([this.listBaby = const []]) {
    count = listBaby.length;
  }

  @override
  List<Object> get props => [listBaby];

  @override
  String toString() => 'ListBabyLoadSuccess { LenghtListBaby: $count }';
}

class BabyLoadFailure extends BabyState {}
