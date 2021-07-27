import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:senna_work/Models/Address_Model.dart';
import 'package:senna_work/Models/Company_Model.dart';
import 'package:senna_work/Models/Profile_Model.dart';
import 'package:senna_work/Service/Api_Service.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ApiService api = new ApiService();
  static int coutfamily = 1;
  static List<List<String>> Family = [
    ['Senna Family', 'Gift Senna', 'Nun Senna', 'Nooom Senna', 'Pot Senna']
  ];
  static int countMeber = 1;
  static List<String> getPic = [];
  static List<String> getName = [];
  static List<String> getAddress = [];
  static List<String> getCompany = [];
  static List<String> getNCompany = [];

  HomeBloc() : super(InitialHomeState(coutfamily, Family, Family));

  String dropdownvalue = 'Apple';
  String dropdownAdress = ' ';
  String dropdownCompany = ' ';

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is InitialHomeEvent) {
      yield* _mapEventToInitialState();
    } else if (event is LoadingEvent) {
      yield* _mapEventToLoading();
    } else if (event is AddFamilyEvent) {
      yield* _mapEventToAddFamily(countMeber);
    } else if (event is AddMemberEvent) {
      yield* _mapEventToAddMember();
    } else if (event is updateFamilyEvent) {
      yield* _mapEventToUpdateF(event.Fname, event.name, event.picture);
    } else if (event is updateMemberEvent) {
      yield* _mapEventToUpdateM(
          event.name, event.adress, event.company, event.picture);
    }
    else if (event is delEvent) {
      yield* _mapEventToDel(event.name);
    }
    else if (event is delMemberEvent) {
      yield* _mapEventToDelMember(event.index);
    }

    // TODO: Add your event logic
  }

  Stream<HomeState> _mapEventToInitialState() async* {
    yield LoadingState();
    await Future.delayed(Duration(seconds: 2));
  }

  Stream<HomeState> _mapEventToAddFamily(int count) async* {
    List<String> empty = [];
    yield LoadingState();
    await Future.delayed(Duration(seconds: 2));
    yield AddFamilyState(count, empty, empty, empty, empty, empty);
  }

  Stream<HomeState> _mapEventToAddMember() async* {
    print('Addtomember');
    final String _urlCompany =
        'https://fakerapi.it/api/v1/companies?_quantity=1';
    final String _urlAddress =
        'https://fakerapi.it/api/v1/addresses?_quantity=1';
    final String _urlPicture =
        'https://fakerapi.it/api/v1/images?_quantity=1&_type=kittens&_height=300';
    yield LoadingState();
    var resCompany = await api.getApiService(_urlCompany);
    var resAddress = await api.getApiService(_urlAddress);
    var resPicture = await api.getApiService(_urlPicture);
    List<String> getAddress = [' '];
    List<String> getCompany = [' '];
    List<String> getPicture = [' '];
    for (int i = 0; i < 4; i++) {
      await Future.delayed(Duration(milliseconds: 500));
      getAddress.add(AddressModels.fromJson(resAddress).data[0].street);
      getCompany
          .add(CompanyModels.fromJson(resCompany).data[0].addresses[0].street);
      getNCompany.add(CompanyModels.fromJson(resCompany).data[0].name);
      getPicture.add(ProfileModel.fromJson(resPicture).data[0].url);
      resAddress = await api.getApiService(_urlAddress);
      resCompany = await api.getApiService(_urlCompany);
      resPicture = await api.getApiService(_urlPicture);
    }
    yield AddMemberState(getAddress[0], getCompany[0], getPicture[0], getAddress, getCompany, getPicture);
  }

  Stream<HomeState> _mapEventToLoading() async* {
    yield LoadingState();
  }

  Stream<HomeState> _mapEventToUpdateM(name, adress, company, picture) async* {
    yield LoadingState();
    await Future.delayed(Duration(seconds: 2));
    print(adress);
    print(company);
    countMeber++;
    getName.add(name);
    getAddress.add(adress);
    getCompany.add(company);
    getPic.add(picture);
    yield AddFamilyState(countMeber, getName, getAddress, getNCompany, getCompany, getPic);

  }

  Stream<HomeState> _mapEventToUpdateF(fname, name, picture) async* {
    yield LoadingState();
    await Future.delayed(Duration(seconds: 2));
    coutfamily++;
    name.insert(0, fname);
    Family.add(name);
    yield InitialHomeState(coutfamily, Family, getPic);
    countMeber = 1;
  }

  Stream<HomeState> _mapEventToDel(name,) async* {
    yield LoadingState();
    await Future.delayed(Duration(seconds: 2));
    coutfamily--;
    Family.remove(name);
    yield InitialHomeState(coutfamily, Family, getPic);
  }

  Stream<HomeState> _mapEventToDelMember(index) async* {
    yield LoadingState();
    await Future.delayed(Duration(seconds: 2));
    Family.removeAt(index+1);
    countMeber--;
    getName.removeAt(index);
    getAddress.removeAt(index);
    getCompany.removeAt(index);
    getPic.removeAt(index);
    yield AddFamilyState(countMeber, getName, getAddress, getNCompany, getCompany, getPic);
  }
}
