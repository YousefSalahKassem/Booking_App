import 'package:bookingapp/app.dart';
import 'package:bookingapp/bloc_observer.dart';
import 'package:bookingapp/injection_container.dart' as di;
import 'package:bookingapp/src/core/api/dio_consumer.dart';
import 'package:bookingapp/src/core/services/form_validation/validation_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'injection_container.dart';

void main() async {
  GoogleFonts.config.allowRuntimeFetching = false;
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = AppBlocObserver(); // runZoned is deprecated
  DioConsumer(client: sl());
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => ValidationHelper(),
    child: const BookingApp(),
  ));
}
