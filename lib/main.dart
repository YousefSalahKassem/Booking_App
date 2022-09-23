import 'package:bookingapp/app.dart';
import 'package:bookingapp/bloc_observer.dart';
import 'package:bookingapp/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = AppBlocObserver(); // runZoned is deprecated
  runApp(const BookingApp());
}
