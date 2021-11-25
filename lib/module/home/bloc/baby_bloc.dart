import 'dart:async';

import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:flutter_babycare/data/source/baby_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'baby_event.dart';
import 'baby_state.dart';

class BabyBloc extends Bloc<BabyEvent, BabyState> {
  final BabyRepository babyRepository;
  StreamSubscription babySubscription;
  List<BabyModel> listBabyModel;

  BabyBloc(
      {BabyRepository babyRepository,
      BabyModel babyModel,
      String idBaby,
      String userId})
      : this.babyRepository = babyRepository,
        super(BabyLoading());

  @override
  Stream<BabyState> mapEventToState(BabyEvent event) async* {
    if (event is LoadBaby) {
      yield* mapBabyLoadedToState(event);
    }
    if (event is AddedBaby) {
      yield* mapBabyAddedToState(event);
    }
    if (event is UpdateListBaby) {
      yield* mapUpdateListBabyToState(event);
    }
    if (event is UpdateBaby) {
      yield* mapUpdateBabyToState(event);
    }
  }

  Stream<BabyState> mapUpdateBabyToState(UpdateBaby event) async* {
    babySubscription = babyRepository
        .updateBaby(babyModel: event.babyModel, idBaby: event.idBaby)
        .listen((baby) => getListBaby(event));
  }

  Stream<BabyState> mapBabyAddedToState(AddedBaby event) async* {
    babySubscription = babyRepository
        .addItem(babyModel: event.babyModel)
        .listen((baby) => getListBaby(event));
  }

  Stream<BabyState> mapBabyLoadedToState(LoadBaby event) async* {
    getListBaby(event);
  }

  Stream<BabyState> mapUpdateListBabyToState(UpdateListBaby event) async* {
    yield BabyLoaded(event.listBaby);
  }

  void getListBaby(BabyEvent event){
    babySubscription =
        babyRepository.getAllBaby(event.userId).listen((baby) => add(
          UpdateListBaby(listBaby: baby),
        ));
  }

}
