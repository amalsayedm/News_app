import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_states.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/network/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{

  int current_index=0;
  List<Widget> screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),

  ];
  List businessList=[];
  List sportsList=[];
  List scienceList=[];
  List searchList=[];


  NewsCubit() : super(NewsIntState()){
    getBusinessList();
  }

  static NewsCubit get(context){
   return BlocProvider.of(context);
  }

  changeNavBarIndex(int index){
    current_index=index;
    if(index==1){
      getSportsList();
    }else if(index==2){
      getScienceList();
    }
    emit(NewsNavBarState());
  }

  void getBusinessList(){
    if(businessList.length==0) {
      DioHelper.getData(path: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '1d7e7456c3aa4de28f4032c76e6f89fd'
      }).then((value) {
        businessList = value.data['articles'];
        print(businessList[0]['title']);
        emit(NewsGetBusinessState());
      }).catchError((error) {
        print(error.toString());
      });
    }else{
      emit(NewsGetBusinessState());

    }
  }

  void getSportsList(){
    if(sportsList.length==0) {
      DioHelper.getData(path: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '1d7e7456c3aa4de28f4032c76e6f89fd'
      }).then((value) {
        sportsList = value.data['articles'];
        print(sportsList[0]['title']);
        emit(NewsGetSportsState());
      }).catchError((error) {
        print(error.toString());
      });
    }else{
      emit(NewsGetSportsState());

    }
  }
  void getScienceList(){
    if(scienceList.length==0) {
      DioHelper.getData(path: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '1d7e7456c3aa4de28f4032c76e6f89fd'
      }).then((value) {
        scienceList = value.data['articles'];
        print(scienceList[0]['title']);
        emit(NewsGetScienceState());
      }).catchError((error) {
        print(error.toString());
      });
    }else{
      emit(NewsGetScienceState());

    }
  }

  void getSearchList(String value) {
    if (value.isNotEmpty) {
      emit(NewsGetSearchLoadingState());
      DioHelper.getData(path: 'v2/everything', query: {
        'q': '$value',
        'apiKey': '1d7e7456c3aa4de28f4032c76e6f89fd'
      }).then((value) {
        searchList = value.data['articles'];
        print(searchList[0]['title']);
        emit(NewsGetSearchState());
      }).catchError((error) {
        print(error.toString());
      });
    }
  }

}