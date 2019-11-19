import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resto_app/data/service/ApiClient.dart';
import 'package:resto_app/model/resto.dart';
import './bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  @override
  MainState get initialState => InitialMainState();

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if(event is LoadResto){
      yield LoadingResto();
      yield* _mapEventLoadResto();
    }
  }

  Stream<MainState> _mapEventLoadResto() async* {
    try {
      var location = new Location();
      LocationData userLocation;

      userLocation = await location.getLocation();
      Resto resto = await ApiClient().getListResto(userLocation.latitude, userLocation.longitude);
      await Future.delayed(Duration(seconds: 1));
      if(resto != null){
        yield SuccessLoadResto(resto);
      } else {
        yield ErrorLoadResto();
      }
    } catch(e){
      print(e);
      yield ErrorLoadResto();
    }
  }
}
