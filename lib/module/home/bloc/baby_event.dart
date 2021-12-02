import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:flutter_babycare/data/model/bmi_model.dart';
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

class FetchBMI extends BabyEvent {
  final String idBaby;

  FetchBMI({this.idBaby});

  @override
  List<Object> get props => [idBaby];
}

class FetchedBMI extends BabyEvent {
  final List<BmiModel> listBmi;

  FetchedBMI({this.listBmi});

  @override
  List<Object> get props => [listBmi];
}

class CreateBMI extends BabyEvent {
  final List<BmiModel> listBMIModel;

  CreateBMI({this.listBMIModel});

  @override
  List<Object> get props => [listBMIModel];
}

class LoadBMIEvent extends BabyEvent {
  final List<BmiModel> listBMIModel;

  LoadBMIEvent({this.listBMIModel});

  @override
  List<Object> get props => [listBMIModel];
}

class CreateBaby extends BabyEvent {
  final BabyModel babyModel;

  const CreateBaby({this.babyModel}) : super();

  @override
  List<Object> get props => [this.babyModel];
}

class CreatedBabyEvent extends BabyEvent {
  final String idBaby;

  const CreatedBabyEvent({this.idBaby}) : super();

  @override
  List<Object> get props => [this.idBaby];
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

class UpdateListBaby extends BabyEvent {
  final List<BabyModel> listBaby;

  UpdateListBaby({this.listBaby}) : super();

  @override
  List<Object> get props => [listBaby];

  @override
  String toString() => 'listBabyUpdated { updatedListBaby: $listBaby }';
}

