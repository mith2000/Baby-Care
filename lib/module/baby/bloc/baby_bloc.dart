import 'dart:async';

import 'package:flutter_babycare/data/source/baby_repository.dart';
import 'package:flutter_babycare/module/baby/bloc/baby_event.dart';
import 'package:flutter_babycare/module/baby/bloc/baby_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BabyBloc extends Bloc<BabyEvent, BabyState> {
  final BabyRepository babyRepository;
  StreamSubscription babySubscription;

  BabyBloc({BabyRepository babyRepository})
      : this.babyRepository = babyRepository,
        super(BabyLoading());


  @override
  Stream<BabyState> mapEventToState(BabyEvent event) async* {
    if (event is LoadBaby) {
      yield* mapBabyLoadedToState();
    }
    if (event is UpdateBaby) {
      yield* mapUpdateBabyToState(event);
    }
  }

  Stream<BabyState> mapBabyLoadedToState() async* {
    babySubscription = babyRepository.getAllBaby().listen((baby) => add(
          UpdateBaby(listBaby: baby),
        ));
  }

  Stream<BabyState> mapUpdateBabyToState(UpdateBaby event) async* {
    yield BabyLoaded(listBaby: event.listBaby);
  }
}
