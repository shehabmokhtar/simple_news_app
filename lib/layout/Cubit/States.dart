
abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsBottomNavState extends NewsState {}

class NewsGetBusinessLoadingState extends NewsState {}

class NewsGetBusinessSuccessState extends NewsState {}

class NewsGetBusinessErrorState extends NewsState {
  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsState {}

class NewsGetSportsSuccessState extends NewsState {}

class NewsGetSportsErrorState extends NewsState {
  final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetSiencesLoadingState extends NewsState {}

class NewsGetSciencesSuccessState extends NewsState {}

class NewsGetSciencesErrorState extends NewsState {
  final String error;

  NewsGetSciencesErrorState(this.error);
}

class NewsGetSearchLoadingState extends NewsState {}

class NewsGetSearchSuccessState extends NewsState {}

class NewsGetSearchErrorState extends NewsState {
  final String error;

  NewsGetSearchErrorState(this.error);
}

class ModethemeInitial extends NewsState {}

class NewsModeChange extends NewsState {}