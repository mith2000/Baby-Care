import 'dart:async';

import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:flutter_babycare/data/source/baby_repository.dart';
import 'package:flutter_babycare/data/source/bmi_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'baby_event.dart';
import 'baby_state.dart';

class BabyBloc extends Bloc<BabyEvent, BabyState> {
  final BabyRepository babyRepository;
  final BmiRepository bmiRepository;
  StreamSubscription babySubscription;
  List<BabyModel> listBabyModel;

  BabyBloc({
    BabyRepository babyRepository,
    BmiRepository bmiRepository,
    BabyModel babyModel,
  })  : this.babyRepository = babyRepository,
        this.bmiRepository = bmiRepository,
        super(BabyLoading());

  @override
  Stream<BabyState> mapEventToState(BabyEvent event) async* {
    if (event is LoadBaby) {
      yield* mapBabyLoadedToState(event);
    }
    if (event is CreateBaby) {
      yield* mapBabyAddedToState(event);
    }
    if (event is CreatedBabyEvent) {
      yield* mapCreatedBabyEventToState(event);
    }
    if (event is UpdateListBaby) {
      yield* mapUpdateListBabyToState(event);
    }
    if (event is NameBabyChange) {
      yield* mapNameBabyChangeToState(event);
    }
    if (event is BirthBabyChange) {
      yield* mapBirthBabyChangeToState(event);
    }
    if (event is AddImageInFireBase) {
      yield* mapAddImageToState(event);
    }
    if (event is AddedImage) {
      yield* mapAddedImageToState(event);
    }
    if (event is CreateBMI) {
      yield* mapCreateBMIToState(event);
    }
    if (event is FetchBMI) {
      yield* mapFetchBMIToState(event);
    }
    if (event is FetchedBMI) {
      yield* mapFetchedBMToState(event);
    }
    if (event is UpdateBMIEvent) {
      yield* mapUpdateBMIEventToState(event);
    }
  }

  Stream<BabyState> mapUpdateBMIEventToState(UpdateBMIEvent event) async* {
    babySubscription = bmiRepository
        .updateBMI(listBMIModel: event.listBmi, idBaby: event.listBmi[0].idBaby)
        .listen((listBMI) => add(FetchedBMI(listBmi: listBMI)));
  }

  Stream<BabyState> mapFetchBMIToState(FetchBMI event) async* {
    babySubscription = bmiRepository
        .fetchBmi(event.idBaby)
        .listen((listBMI) => add(FetchedBMI(listBmi: listBMI)));
  }

  Stream<BabyState> mapFetchedBMToState(FetchedBMI event) async* {
    yield LoadBMIBaby(list: event.listBmi);
  }

  Stream<BabyState> mapCreateBMIToState(CreateBMI event) async* {
    babySubscription = bmiRepository
        .createBmi(event.listBMIModel)
        .listen((listBMI) => add(FetchedBMI(listBmi: listBMI)));
  }

  Stream<BabyState> mapAddImageToState(AddImageInFireBase event) async* {
    babySubscription = babyRepository
        .addImageInFireBase(idAccount: event.idAccount, xFile: event.file)
        .asStream()
        .listen((urlImage) => add(AddedImage(urlImage: urlImage)));
  }

  Stream<BabyState> mapAddedImageToState(AddedImage event) async* {
    yield UploadedImageBaby(event.urlImage);
  }

  Stream<BabyState> yieldBabyUploadedImageState(String urlImage) async* {
    yield UploadedImageBaby(urlImage);
  }

  Stream<BabyState> mapNameBabyChangeToState(NameBabyChange event) async* {
    yield state.update(isNameValid: true); // Bỏ validate dô
  }

  Stream<BabyState> mapBirthBabyChangeToState(BirthBabyChange event) async* {
    yield state.update(isBirthValid: true); // Bỏ validate dô
  }

  Stream<BabyState> mapBabyAddedToState(CreateBaby event) async* {
    babySubscription = babyRepository
        .createBaby(babyModel: event.babyModel)
        .asStream()
        .listen((idBaby) => add(CreatedBabyEvent(idBaby: idBaby)));
  }

  Stream<BabyState> mapCreatedBabyEventToState(CreatedBabyEvent event) async* {
    yield BabyCreated(idBaby: event.idBaby);
  }

  Stream<BabyState> mapBabyLoadedToState(LoadBaby event) async* {
    getListBaby(event);
  }

  Stream<BabyState> mapUpdateListBabyToState(UpdateListBaby event) async* {
    yield BabyLoaded(event.listBaby);
  }

  void getListBaby(BabyEvent event) {
    babySubscription =
        babyRepository.fetchAllBaby(event.userId).listen((baby) => add(
              UpdateListBaby(listBaby: baby),
            ));
  }
}
