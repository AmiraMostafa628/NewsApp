import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/screens/businessScreen.dart';
import 'package:newsapp/screens/scienceScreen.dart';
import 'package:newsapp/screens/sportScreen.dart';
import 'package:newsapp/shared/cubit/states.dart';
import 'package:newsapp/shared/network/local/cacheHelper.dart';
import 'package:newsapp/shared/network/remote/dioHelper.dart';

class NewsCubit extends Cubit<AppStates>{

  NewsCubit(): super(AppInitialState());

 static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeIndex(index)
  {
    currentIndex = index;
    emit(AppBotomNavBarState());
  }
  List <Widget> Screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),

  ];

  List <dynamic> business=[];
  int businessItem=0;
  bool isDesktop = false;
  void setDesktop(bool value)
  {
    isDesktop=value;
    emit(AppsetDesktopSuccessData());
  }
  void getBusinessData(){
    emit(AppLoadingBusinessData());
    DioHelper.getData(
        url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'business',
        'apiKey': 'b7060b8bcb4441e4a7ddc98f41f52c19'
      }
    ).then((value) {
      business=value.data['articles'];
      print(business[0]['title']);
      emit(AppGetBusinessSuccessData());
    }).catchError((error){
      print(error.toString());
      emit(AppGetBusinessErrorData());
    });

  }
  void businessItemSelect(index)
  {
    businessItem=index;
      emit(AppBusinessSelectedItemData());

    }

  List <dynamic> science=[];

  void getScienceData(){
    emit(AppLoadingScienceData());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'science',
          'apiKey': 'b7060b8bcb4441e4a7ddc98f41f52c19'
        }
    ).then((value) {
      science= value.data['articles'];
      print(science[0]['title']);
      emit(AppGetScienceSuccessData());
    }).catchError((error){
      print(error.toString());
      emit(AppGetSportErrorData());
    });
  }

  List <dynamic> sport=[];

  void getSportData(){
    emit(AppLoadingSportData());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'sport',
          'apiKey': 'b7060b8bcb4441e4a7ddc98f41f52c19'
        }
    ).then((value) {
      sport= value.data['articles'];
      print(sport[0]['title']);
      emit(AppGetSportSuccessData());
    }).catchError((error){
      print(error.toString());
      emit(AppGetSportErrorData());
    });
  }

  List <dynamic> search=[];

  void SearchData(value){
    emit(AppLoadingSearchData());
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apiKey': 'b7060b8bcb4441e4a7ddc98f41f52c19'
        }
    ).then((value) {
      search= value.data['articles'];
      print(search[0]['title']);
      emit(AppGetSearchSuccessData());
    }).catchError((error){
      print(error.toString());
      emit(AppGetSearchErrorData());
    });
  }

  bool isDark = false;

  void changeMode({bool? fromshared})
  {

    if(fromshared !=null) {
      isDark = fromshared;
      emit(AppChangeBottomModeState());
    }
    else
      {
        isDark=!isDark;
        CacheHelper.saveData(key: 'isDark', value:isDark).then((value) {
          emit(AppChangeBottomModeState());
        });

      }
  }



}