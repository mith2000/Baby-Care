// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/data/model/baby/baby_model.dart';
import 'package:flutter_babycare/data/model/baby/bmi_model.dart';
import 'package:flutter_babycare/data/model/baby/list_food_model.dart';
import 'package:flutter_babycare/data/model/baby/ni_model.dart';

class BabyState extends Equatable {
  @override
  List<Object> get props => [];
}

class BabyInitial extends BabyState {}

class UploadedImageBaby extends BabyState {
  final String urlImage;

  UploadedImageBaby([this.urlImage]);

  @override
  List<Object> get props => [urlImage];

  @override
  String toString() => 'Upload image success { urlImage: $urlImage }';
}

class LoadedBMI extends BabyState {
  final List<BmiModel> list;

  LoadedBMI({this.list});

  @override
  List<Object> get props => [list];
}

class LoadedFood extends BabyState {
  final List<ListFoodModel> list;

  LoadedFood({this.list});

  @override
  List<Object> get props => [list];
}

class LoadedNI extends BabyState {
  final List<NIModel> list;

  LoadedNI({this.list});

  @override
  List<Object> get props => [list];
}

class LoadedBMIAndNI extends BabyState {
  final List<NIModel> listNI;
  final List<BmiModel> listBMI;
  int countNI;
  int countBMI;

  LoadedBMIAndNI({this.listNI, this.listBMI}) {
    countNI = listNI.length;
    countBMI = listBMI.length;
  }

  @override
  List<Object> get props => [listNI, listBMI];

  @override
  String toString() =>
      'FetchedBMIAndNI { LenghtNI: $countNI ,LenghtBMI:  $countBMI}';
}

class BabyLoading extends BabyState {}

class ImageLoading extends BabyState {}

class FoodLoading extends BabyState {}

class FoodAndBMILoading extends BabyState {}

class NILoading extends BabyState {}

class LoadedBaby extends BabyState {
  final List<BabyModel> listBaby;
  int count;

  LoadedBaby([this.listBaby = const []]) {
    count = listBaby.length;
  }

  @override
  List<Object> get props => [listBaby];

  @override
  String toString() => 'ListBabyLoadSuccess { LenghtListBaby: $count }';
}

class BabyLoadFailure extends BabyState {}
