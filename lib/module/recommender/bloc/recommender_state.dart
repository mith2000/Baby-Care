// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class RecommenderState extends Equatable {
  @override
  List<Object> get props => [];
}

class RecommenderInitial extends RecommenderState {}

class RecommenderLoading extends RecommenderState {}

class ThemeLoadFailure extends RecommenderState {}
