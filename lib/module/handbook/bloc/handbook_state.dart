// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/data/model/handbook/theme_handbook_model.dart';

class HandBookState extends Equatable {
  @override
  List<Object> get props => [];
}

class HandBookInitial extends HandBookState {}

class LoadedTheme extends HandBookState {
  final List<ThemeHandBookModel> list;

  LoadedTheme({this.list});

  @override
  List<Object> get props => [list];
}

class ThemeLoading extends HandBookState {}

class ThemeLoadFailure extends HandBookState {}
