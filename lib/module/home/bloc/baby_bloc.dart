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

  BabyBloc({BabyRepository babyRepository, BabyModel babyModel})
      : this.babyRepository = babyRepository,
        this.babyModel = babyModel,
        super(BabyLoading());

  @override
  Stream<BabyState> mapEventToState(BabyEvent event) async* {
    if (event is LoadBaby) {
      yield* mapBabyLoadedToState();
    }
    if (event is AddedBaby) {
      yield* mapBabyAddedToState(babyModel);
    }
    if (event is UpdateBaby) {
      yield* mapUpdateBabyToState(event);
    }
  }

  Stream<BabyState> mapBabyAddedToState(BabyModel model) async* {
    babySubscription = babyRepository
        .addItem(babyModel: model)
        .listen((baby) => add(UpdateBaby()));
  }

  Stream<BabyState> mapBabyLoadedToState() async* {
    babySubscription = babyRepository.getAllBaby().listen((baby) => add(
          UpdateBaby(listBaby: baby),
        ));
  }

  Stream<BabyState> mapUpdateBabyToState(UpdateBaby event) async* {
    yield BabyLoaded(event.listBaby);
  }
}
