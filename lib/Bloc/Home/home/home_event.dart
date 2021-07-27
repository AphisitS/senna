part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class InitialHomeEvent extends HomeEvent{
  @override
  String toString() => "InitialHomeState ";
}
class LoadingEvent extends HomeEvent{
  @override
  String toString() => "LoadingEvent ";
}

class AddFamilyEvent extends HomeEvent{
  @override
  String toString() => "AddFamilyEvent ";
}

class AddMemberEvent extends HomeEvent{
  @override
  String toString() => "AddMemberEvent ";
}
class LoadData extends HomeEvent{
  @override
  String toString() => "LoadData ";
}

class LoadataEvent extends HomeEvent{
  @override
  String toString() => "LoadataEvent";
}
class updateMemberEvent extends HomeEvent{
  String name,adress,company,picture;
  updateMemberEvent(this.name,this.adress,this.company,this.picture);
  @override
  String toString() => "updateMemberEvent";
}

class updateFamilyEvent extends HomeEvent{
  String Fname;
  List<String> name=[],picture=[];
  updateFamilyEvent(this.Fname,this.name,this.picture);
  @override
  String toString() => "updateFamilyEvent";
}

class delEvent extends HomeEvent{
  List<String> name=[];
  delEvent(this.name);
  @override
  String toString() => "updateFamilyEvent";
}

class delMemberEvent extends HomeEvent{
 int index;
  delMemberEvent(this.index);
  @override
  String toString() => "updateFamilyEvent";
}
