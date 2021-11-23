import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';

abstract class BabyEvent extends Equatable {
  const BabyEvent();

  @override
  List<Object> get props => [];
}

class LoadBaby extends BabyEvent {}

class UpdateBaby extends BabyEvent {
  final List<BabyModel> listBaby;

  UpdateBaby({this.listBaby});

  @override
  List<Object> get props => [listBaby];
}
