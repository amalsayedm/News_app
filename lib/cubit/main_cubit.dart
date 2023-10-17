
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/main_states.dart';
import 'package:news_app/shared_components/shared_pref_helper.dart';

class MainCubit extends Cubit<MainStates>{

  MainCubit() : super(MainInitialState());

  static MainCubit get(context){
    return BlocProvider.of(context);
  }

  bool lightMode=  true;

  getThemeMode(){
    bool mode=SharedPrefHelper.getThemeMode(key: 'light_mode');
    if(mode!=null){
       lightMode=mode;
    }

  }
  void toggleThemeMode(){
    lightMode=!lightMode;
    SharedPrefHelper.setThemeMode(key: 'light_mode', value: lightMode).then((value){
      emit(MainChangeThemeState());

    });

  }

}