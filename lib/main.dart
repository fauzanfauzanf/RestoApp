import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_app/ui/bloc/bloc.dart';
import 'package:resto_app/ui/bloc/simple_bloc_delegate.dart';
import 'package:resto_app/ui/main/main_screen.dart';

void main(){
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
      MainScreen()
  );
}