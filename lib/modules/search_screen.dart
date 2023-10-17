import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/news_states.dart';
import 'package:news_app/shared_components/shared_components.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>( listener: (context,state){},
      builder: (context,state){
      NewsCubit c=NewsCubit.get(context);
      return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultFormField(
                onChange: (String value){
                  c.getSearchList(value);
                },
                  controller: textEditingController,
                  inputType: TextInputType.text,
                  labeltext: 'search',
                  prefixicon: Icons.search,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "please enter text";
                    }
                    return null;
                  }),
            ),
            ConditionalBuilder(condition:state is! NewsGetSearchLoadingState,builder: (context){
              return Expanded(
                child: ListView.separated(
                itemCount: c.searchList.length,
                itemBuilder: (context, index) {
                  return buildNewsItem(c.searchList[index], context);
                },
                separatorBuilder: (context, index) {
                  return Container(
                      width: double.infinity, height: 1.0, color: Colors.grey[300]);
                },
            ),
              );},
            fallback:(context){ return Center(child: CircularProgressIndicator());} ,),
          ],
        ),
      );
      },);
  }
}
