import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/main_cubit.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/news_states.dart';
import 'package:news_app/modules/search_screen.dart';
import 'package:news_app/shared_components/shared_components.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          NewsCubit c= NewsCubit.get(context);
          return Scaffold(appBar:AppBar(
            title: Text("News App"),
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: (){
                navigateTo(context,SearchScreen());
              }),
              IconButton(icon: Icon(Icons.brightness_4_sharp), onPressed: (){
                MainCubit.get(context)..toggleThemeMode();
              }),

            ],
          ) ,
            body: c.screens[c.current_index],
            bottomNavigationBar:BottomNavigationBar(
              currentIndex: c.current_index,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.business_center),title: Text("Business")),
                BottomNavigationBarItem(icon:  Icon(Icons.sports),title: Text("Sports")),
                BottomNavigationBarItem(icon:  Icon(Icons.science),title: Text("Science")),

              ],
            onTap: (int index){
                c.changeNavBarIndex(index);
            },),);
        },

        );


  }
}
