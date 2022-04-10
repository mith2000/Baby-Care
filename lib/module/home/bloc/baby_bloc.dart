import 'dart:async';
import 'dart:developer';

import '../../../data/model/baby/baby_model.dart';
import '../../../data/source/baby/baby_repository.dart';
import '../../../data/source/baby/bmi_repository.dart';
import '../../../data/source/baby/food_repository.dart';
import '../../../data/source/baby/ni_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'baby_event.dart';
import 'baby_state.dart';

class BabyBloc extends Bloc<BabyEvent, BabyState> {
  List<BabyModel> listBabyModel;

  BabyBloc({
    BabyModel babyModel,
  }) : super(BabyInitial());

  @override
  Stream<BabyState> mapEventToState(BabyEvent event) async* {
    //Baby
    if (event is LoadBaby) {
      yield BabyLoading();
      yield* mapBabyLoadedToState(event);
    }
    if (event is CreateBaby) {
      yield BabyLoading();
      yield* mapCreateBabyToState(event);
    }
    if (event is UpdateBaby) {
      yield BabyLoading();
      yield* mapUpdateBabyToState(event);
    }
    if (event is AddImageInFireBase) {
      yield ImageLoading();
      yield* mapAddImageToState(event);
    }
    //BMI
    if (event is CreateBMI) {
      yield FoodAndBMILoading();
      yield* mapCreateBMIToState(event);
    }
    if (event is LoadBMI) {
      yield FoodAndBMILoading();
      yield* mapLoadBMIToState(event);
    }
    if (event is UpdateBMI) {
      yield FoodAndBMILoading();
      yield* mapUpdateBMIToState(event);
    }
    //Food
    if (event is CreateFood) {
      yield FoodLoading();
      yield* mapCreateFoodToState(event);
    }
    if (event is FetchFood) {
      yield FoodLoading();
      yield* mapFetchFoodToState(event);
    }
    if (event is FetchNI) {
      yield NILoading();
      yield* mapFetchNIToState(event);
    }
    if (event is UpdateFood) {
      yield FoodLoading();
      yield* mapUpdateFoodEventToState(event);
    }
    //BMI and Food
    if (event is FetchBMIAndNI) {
      yield FoodAndBMILoading();
      yield* mapFetchBMIAndNIToState(event);
    }
  }

  Stream<BabyState> mapUpdateFoodEventToState(UpdateFood event) async* {
    String idBaby = await FoodRepository.updateFood(event.listFood);
    yield LoadedBMIAndNI(
        listBMI: await BmiRepository.fetchBmi(idBaby),
        listNI: await NIRepository.fetchNi(idBaby));
  }

  Stream<BabyState> mapFetchBMIAndNIToState(FetchBMIAndNI event) async* {
    yield LoadedBMIAndNI(
        listBMI: await BmiRepository.fetchBmi(event.idBaby),
        listNI: await NIRepository.fetchNi(event.idBaby));
  }

  Stream<BabyState> mapFetchNIToState(FetchNI event) async* {
    yield LoadedNI(list: await NIRepository.fetchNi(event.idBaby));
  }

  Stream<BabyState> mapCreateFoodToState(CreateFood event) async* {
    String idBaby = await FoodRepository.createFood(event.listFoodModel);
    yield LoadedFood(list: await FoodRepository.fetchFood(idBaby, 0));
  }

  Stream<BabyState> mapFetchFoodToState(FetchFood event) async* {
    yield LoadedFood(list: await FoodRepository.fetchFood(event.idBaby, 0));
  }

  Stream<BabyState> mapUpdateBMIToState(UpdateBMI event) async* {
    String idBaby = await BmiRepository.updateBMI(
        listBMIModel: event.listBmi, idBaby: event.idBaby);
    yield LoadedBMIAndNI(
        listBMI: await BmiRepository.fetchBmi(idBaby),
        listNI: await NIRepository.fetchNi(idBaby));
  }

  Stream<BabyState> mapLoadBMIToState(LoadBMI event) async* {
    yield LoadedBMI(list: await BmiRepository.fetchBmi(event.idBaby));
  }

  Stream<BabyState> mapCreateBMIToState(CreateBMI event) async* {
    var idBaby = await BmiRepository.createBmi(event.listBMIModel);
    yield LoadedBMI(list: await BmiRepository.fetchBmi(idBaby));
  }

  Stream<BabyState> mapAddImageToState(AddImageInFireBase event) async* {
    yield UploadedImageBaby(await BabyRepository.addImageInFireBase(
        xFile: event.file, idAccount: event.idAccount));
  }

  Stream<BabyState> mapCreateBabyToState(CreateBaby event) async* {
    listBabyModel = [];
    listBabyModel = await BabyRepository.createBaby(babyModel: event.babyModel);
    yield LoadedBaby(listBabyModel);
  }

  Stream<BabyState> mapBabyLoadedToState(LoadBaby event) async* {
    listBabyModel = [];
    listBabyModel = await BabyRepository.fetchAllBaby(event.userId);
    yield LoadedBaby(listBabyModel);
  }

  Stream<BabyState> mapUpdateBabyToState(UpdateBaby event) async* {
    List<BabyModel> babyModel = [];
    await BabyRepository.updateBaby(babyModel: event.babyModel);
    babyModel.add(await BabyRepository.fetchBaby(event.babyModel.id));
    yield LoadedBaby(babyModel);
  }
}
