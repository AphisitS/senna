part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class InitialHomeState extends HomeState {
  List<dynamic> getValue = [];
  int countFamily;
  List<List<String>> Family;
  InitialHomeState(this.countFamily,this.Family,this.getValue,);
}

class LoadingState extends HomeState {
}
class AddFamilyState extends HomeState {
  int countMember;
  List<String>name = [],adress = [],ncompany  = [],company  = [],picture = [];
  AddFamilyState(this.countMember,this.name,this.adress,this.ncompany,this.company,this.picture);
}
class AddMemberState extends HomeState {
  String i,j,k;
  List<String> adress,company,piture = [];
  AddMemberState(this.i,this.j,this.k,this.adress,this.company,this.piture);
}
class upDateState extends HomeState {

}



class ChangState extends HomeState {
  String i,j;
  List<String> adress,company = [];
  ChangState(this.i,this.j,this.adress,this.company);
}