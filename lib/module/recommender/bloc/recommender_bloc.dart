import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'recommender_event.dart';
import 'recommender_state.dart';

class RecommenderBloc extends Bloc<RecommenderEvent, RecommenderState> {
  RecommenderBloc() : super(RecommenderInitial());

  @override
  Stream<RecommenderState> mapEventToState(RecommenderEvent event) async* {}
}
