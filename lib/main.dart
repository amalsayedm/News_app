import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/cubit/main_cubit.dart';
import 'package:news_app/cubit/main_states.dart';
import 'package:news_app/network/dio_helper.dart';
import 'package:news_app/shared_components/shared_pref_helper.dart';

import 'cubit/bloc_observer.dart';
import 'cubit/news_cubit.dart';
import 'layout/home_layout.dart';

void main() async{
  //this line ensure that every method in the main has finished then run the app
  // we use it when there is future return from a method
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await SharedPrefHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers:[
        BlocProvider(create:(context){return MainCubit();}),
        BlocProvider(create: (context){return NewsCubit();}),
    ] ,
      child: BlocConsumer<MainCubit,MainStates>(listener: (context,state){},
        builder:(context,state){
        MainCubit.get(context)..getThemeMode();
          return MaterialApp(
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    selectedItemColor: Colors.deepOrange,unselectedItemColor: Colors.grey),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle: TextStyle(
                      color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark),
                  backwardsCompatibility: false,
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange),
                textTheme: TextTheme(bodyText1: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,
                    color:Colors.black))),
            darkTheme: ThemeData(
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    selectedItemColor: Colors.deepOrange,
                    backgroundColor: HexColor('33739'),
                    unselectedItemColor: Colors.grey),
                scaffoldBackgroundColor: HexColor('33739'),
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.white),
                  titleTextStyle: TextStyle(
                      color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  backgroundColor: HexColor('33739'),
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('33739'),
                      statusBarIconBrightness: Brightness.light),
                  backwardsCompatibility: false,
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange),
                textTheme: TextTheme(bodyText1: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,
                    color:Colors.white))),
            themeMode: MainCubit.get(context).lightMode?ThemeMode.light:ThemeMode.dark,
            home: HomeLayout(),
            debugShowCheckedModeBanner: false,
          );
        } ,),);

  }
}
