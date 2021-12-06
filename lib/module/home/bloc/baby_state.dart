import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:flutter_babycare/data/model/bmi_model.dart';
import 'package:flutter_babycare/data/model/food_model.dart';

class BabyState extends Equatable {
  final bool isNameValid;
  final bool isBirthValid;

  BabyState({this.isNameValid, this.isBirthValid});

  @override
  List<Object> get props => [];

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

class BabyCreated extends BabyState {
  final String idBaby;

  BabyCreated({this.idBaby});

  @override
  List<Object> get props => [idBaby];
}

class BabyLoading extends BabyState {}

class BabyLoaded extends BabyState {
  final List<BabyModel> listBaby;

  BabyLoaded([this.listBaby = const []]);

  @override
  List<Object> get props => [listBaby];

  @override
  String toString() => 'ListBabyLoadSuccess { ListBaby: $listBaby }';
}

class BabyLoadFailure extends BabyState {}
