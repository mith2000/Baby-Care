import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';

abstract class BabyState extends Equatable {
  const BabyState();

  @override
  List<Object> get props => [];
}

class BabyLoading extends BabyState {}

class BabyLoaded extends BabyState {
  final List<BabyModel> listBaby;

  BabyLoaded({this.listBaby = const <BabyModel>[]});

  @override
  List<Object> get props => [listBaby];
}
