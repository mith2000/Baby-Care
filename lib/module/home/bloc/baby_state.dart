import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';

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
