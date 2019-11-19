import 'package:equatable/equatable.dart';
import 'package:resto_app/model/resto.dart';

abstract class MainState extends Equatable {
  const MainState();
}

class InitialMainState extends MainState {
  @override
  List<Object> get props => [];
}

class LoadingResto extends MainState {
  @override
  // TODO: implement props
  List<Object> get props => null;

}

class SuccessLoadResto extends MainState {
  final Resto resto;

  SuccessLoadResto(this.resto);

  @override
  // TODO: implement props
  List<Object> get props => [resto];

}

class ErrorLoadResto extends MainState {
  @override
  // TODO: implement props
  List<Object> get props => null;

}