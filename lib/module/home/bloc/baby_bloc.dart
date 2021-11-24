import 'dart:async';

import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:flutter_babycare/data/source/baby_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'baby_event.dart';
import 'baby_state.dart';

class BabyBloc extends Bloc<BabyEvent, BabyState> {
  final BabyRepository babyRepository;
  StreamSubscription babySubscription;
  final BabyModel babyModel;
  final String userId;

  BabyBloc(
      {BabyRepository babyRepository, BabyModel babyModel, String idBaby, String userId})
      : this.babyRepository = babyRepository,
        this.babyModel = babyModel,
        this.userId = userId,
        super(BabyLoading());

  @override
  Stream<BabyState> mapEventToState(BabyEvent event) async* {
    if (event is LoadBaby) {
      yield* mapBabyLoadedToState(event);
    }
    if (event is AddedBaby) {
      yield* mapBabyAddedToState(babyModel);
    }
    if (event is UpdateListBaby) {
      yield* mapUpdateListBabyToState(event);
    }
    if (event is UpdateBaby) {
      //yield* mapUpdateBabyToState();
    }
  }

  Stream<BabyState> mapUpdateBabyToState(BabyModel model,
      String idBaby) async* {
    babySubscription = babyRepository
        .updateBaby(babyModel: model, docId: idBaby)
        .listen((baby) => add(UpdateListBaby()));
  }


  Stream<BabyState> mapBabyAddedToState(BabyModel model) async* {
    babySubscription = babyRepository
        .addItem(babyModel: model)
        .listen((baby) => add(AddedBaby(babyModel)));
  }

  Stream<BabyState> mapBabyLoadedToState(LoadBaby event) async* {
    babySubscription =
        babyRepository.getAllBaby(event.userId).listen((baby) =>
            add(
              UpdateListBaby(listBaby: baby),
            ));
  }

  Stream<BabyState> mapUpdateListBabyToState(UpdateListBaby event) async* {
    yield BabyLoaded(event.listBaby);
  }
}
