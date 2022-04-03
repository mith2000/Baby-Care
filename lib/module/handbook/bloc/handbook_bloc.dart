import 'dart:async';
import 'dart:developer';

import 'package:flutter_babycare/data/model/handbook/theme_handbook_model.dart';
import 'package:flutter_babycare/data/source/handbook_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'handbook_event.dart';
import 'handbook_state.dart';

class HandBookBloc extends Bloc<HandBookEvent, HandBookState> {
  List<ThemeHandBookModel> listTheme;

  HandBookBloc({
    ThemeHandBookModel listTheme,
  }) : super(HandBookInitial());

  @override
  Stream<HandBookState> mapEventToState(HandBookEvent event) async* {
    //Theme
    if (event is LoadThemeHandBook) {
      yield ThemeLoading();
      yield* mapLoadThemeHandBookToState(event);
    }
  }

  Stream<HandBookState> mapLoadThemeHandBookToState(
      LoadThemeHandBook event) async* {
    listTheme = [];
    listTheme = await HandBookRepository.fetchAllThemeHandBook();
    yield LoadedTheme(list: listTheme);
  }
}
