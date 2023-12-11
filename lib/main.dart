import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newapp3/shared/network/local/cache.dart';
import 'package:newapp3/shared/network/remote/dio.dart';
import 'layout/Cubit/Cubit.dart';
import 'layout/Cubit/States.dart';
import 'layout/layout/layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.sharedPreferences!.getString('token');
  Widget widget;

  runApp(
    MyApp(
      isDark: isDark,
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool? isDark;

  MyApp({
    super.key,
    this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusiness()
        ..getSports()
        ..getSciences()
        ..changeMode(),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarBrightness: Brightness.light,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                )),
            scaffoldBackgroundColor: Colors.white,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              elevation: 20,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
            ),
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.deepOrange,
            appBarTheme: AppBarTheme(
                titleSpacing: 20,
                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                //backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarBrightness: Brightness.light,
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                )),
            scaffoldBackgroundColor: HexColor('333739'),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              backgroundColor: HexColor('333739'),
              elevation: 20,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
            ),
          ),
          themeMode:
              NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: Builder(
            builder: (BuildContext context) => NewsLayout(),
          ),
        ),
      ),
    );
  }
}
