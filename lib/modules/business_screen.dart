import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/news_states.dart';
import 'package:news_app/shared_components/shared_components.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>( listener: (context,state){},
      builder: (context,state){
        NewsCubit c=NewsCubit.get(context);
        return ConditionalBuilder(condition: state is! NewsGetBusinessLoadingState,
          builder: (context){
        return ListView.separated(itemCount: c.businessList.length,itemBuilder: (context,index){
          return buildNewsItem(c.businessList[index],context);
        },separatorBuilder: (context,index){return Container(width: double.infinity,
        height: 1.0,
        color: Colors.grey[300]);},);
      },fallback: (context){
        return Center(child: CircularProgressIndicator());
      },);
      },);
  }
}
