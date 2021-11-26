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

  LoadBaby({this.userId}) : super();

  @override
  List<Object> get props => [userId];
}

class AddedBaby extends BabyEvent {
  final BabyModel babyModel;
  final String userId;

  const AddedBaby({this.babyModel, this.userId}) : super();

  @override
  List<Object> get props => [this.babyModel];
}

class NameBabyChange extends BabyEvent {
  final String name;

  const NameBabyChange({this.name});

  @override
  List<Object> get props => [name];
}

class BirthBabyChange extends BabyEvent {
  final double birth;

  const BirthBabyChange({this.birth});

  @override
  List<Object> get props => [birth];
}

class DeletedBaby extends BabyEvent {
  final String idBaby;

  const DeletedBaby({this.idBaby});

  @override
  List<Object> get props => [idBaby];

  @override
  String toString() => 'BabyDeleted { baby: $idBaby }';
}

class UpdateListBaby extends BabyEvent {
  final List<BabyModel> listBaby;

  UpdateListBaby({this.listBaby}) : super();

  @override
  List<Object> get props => [listBaby];

  @override
  String toString() => 'listBabyUpdated { updatedListBaby: $listBaby }';
}

class UpdateBaby extends BabyEvent {
  final BabyModel babyModel;
  final String idBaby;

  UpdateBaby({this.babyModel, this.idBaby}) : super();

  @override
  List<Object> get props => [babyModel];

  @override
  String toString() => 'babyUpdated { updatedBaby: $babyModel }';
}
