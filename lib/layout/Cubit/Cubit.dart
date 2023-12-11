import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/Science/Science.dart';
import '../../modules/Sports/Sports.dart';
import '../../modules/business/business.dart';
import '../../shared/network/local/cache.dart';
import '../../shared/network/remote/dio.dart';
import 'States.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<dynamic> search = [];
  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> sciences = [];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    SciencesScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Sciences',
    ),
  ];

  void changeBottomNavBar(index) {
    currentIndex = index;

    emit(NewsBottomNavState());
  }

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'cb9ddd41adeb4c268676aa8eba7270a1',
      },
    ).then((value) {
      emit(NewsGetBusinessSuccessState());
      business = value.data['articles'];
      print(business.length);
    }).catchError((e) {
      print('error DioHelper getData ' + e.toString());
      emit(NewsGetBusinessErrorState(e.toString()));
    });
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'e728c250e3874f54b5b67b2c9c179f6a',
      },
    ).then((value) {
      sports = value.data['articles'];
      print(sports.length);
      emit(NewsGetSportsSuccessState());
    }).catchError((e) {
      print('error DioHelper getData ' + e.toString());
      emit(NewsGetSportsErrorState(e.toString()));
    });
  }

  void getSciences() {
    emit(NewsGetSiencesLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'e728c250e3874f54b5b67b2c9c179f6a',
      },
    ).then((value) {
      sciences = value.data['articles'];
      print(sciences.length);
      emit(NewsGetSciencesSuccessState());
    }).catchError((e) {
      print('error DioHelper getData ' + e.toString());
      emit(NewsGetSciencesErrorState(e.toString()));
    });
  }

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': 'e728c250e3874f54b5b67b2c9c179f6a',
      },
    ).then((value) {
      search = value.data['articles'];
      print(search.length);
      emit(NewsGetSearchSuccessState());
    }).catchError((e) {
      print('error DioHelper getData ' + e.toString());
      emit(NewsGetSearchErrorState(e.toString()));
    });
  }

  String imageDisplay(image) {
    if (image == null) {
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png';
    } else {
      return image;
    }
  }

  bool isDark = true;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsModeChange());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(NewsModeChange());
      });
    }
  }
}
