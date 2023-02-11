import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/newsLayout.dart';
import 'package:newsapp/shared/blocObserver.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/states.dart';
import 'package:newsapp/shared/network/local/cacheHelper.dart';
import 'package:newsapp/shared/network/remote/dioHelper.dart';
import 'package:newsapp/shared/network/styles/color.dart';
import 'package:newsapp/shared/network/styles/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*if(Platform.isWindows)
    await DesktopWindow.setMinWindowSize(Size(400, 650));*/

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  HttpOverrides.global = MyHttpOverrides();
  dynamic isDark = CacheHelper.getData(key: 'isDark');

  runApp( MyApp(isDark,));
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {

  final dynamic isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>NewsCubit()
        ..getBusinessData()..getScienceData()..getSportData()..changeMode(fromshared: isDark),
      child: BlocConsumer<NewsCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: NewsCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            home:NewsLayout(),
          );
        },
      ),
    );
  }
}

