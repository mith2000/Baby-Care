import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';

abstract class BabyEvent extends Equatable {
  final BabyModel babyModel;
  final String userId;
  const BabyEvent({this.babyModel, this.userId});

  @override
  List<Object> get props => [];
}

class LoadBaby extends BabyEvent {
  final String userId;

  LoadBaby({this.userId}):super();

  @override
  List<Object> get props => [userId];
}

class AddedBaby extends BabyEvent {
  final BabyModel babyModel;
  final String userId;
  const AddedBaby({this.babyModel, this.userId}):super();

  @override
  List<Object> get props => [this.babyModel];
}

class DeletedBaby extends BabyEvent {
  final BabyModel babyModel;

  const DeletedBaby(this.babyModel):super();

  @override
  List<Object> get props => [babyModel];

  @override
  String toString() => 'BabyDeleted { baby: $babyModel }';
}

class UpdateListBaby extends BabyEvent {
  final List<BabyModel> listBaby;

  UpdateListBaby({this.listBaby}):super();

  @override
  List<Object> get props => [listBaby];

  @override
  String toString() => 'listBabyUpdated { updatedListBaby: $listBaby }';
}

class UpdateBaby extends BabyEvent {
  final BabyModel babyModel;
  final String idBaby;

  UpdateBaby({this.babyModel, this.idBaby}):super();

  @override
  List<Object> get props => [babyModel];

  @override
  String toString() => 'babyUpdated { updatedBaby: $babyModel }';
}
