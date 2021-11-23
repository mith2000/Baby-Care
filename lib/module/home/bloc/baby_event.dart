import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';

abstract class BabyEvent extends Equatable {
  const BabyEvent();

  @override
  List<Object> get props => [];
}

class LoadBaby extends BabyEvent {}

class AddedBaby extends BabyEvent {
  final BabyModel babyModel;

  const AddedBaby(this.babyModel);

  @override
  List<Object> get props => [this.babyModel];
}

class DeletedBaby extends BabyEvent {
  final BabyModel babyModel;

  const DeletedBaby(this.babyModel);

  @override
  List<Object> get props => [babyModel];

  @override
  String toString() => 'BabyDeleted { baby: $babyModel }';
}

class UpdateBaby extends BabyEvent {
  final List<BabyModel> listBaby;

  UpdateBaby({this.listBaby});

  @override
  List<Object> get props => [listBaby];

  @override
  String toString() => 'listBabyUpdated { updatedListBaby: $listBaby }';
}
