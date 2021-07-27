import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senna_work/Bloc/Home/home/home_bloc.dart';
import '../Models/Profile_Model.dart';

class HomeObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}

class HomeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: HomeSceen(),
    );
  }
}

class HomeSceen extends StatelessWidget {
  static List<String> getValue = [];

  Future<List<String>> fetchMyModel() async {
    final String _url =
        'https://fakerapi.it/api/v1/images?_quantity=1&_type=kittens&_height=300';
    final Dio _dio = Dio();
    var res = await _dio.get(_url);
    for (int i = 0; i < 2; i++) {
      getValue.add(ProfileModel.fromJson(res.data).data[0].url);
      print(getValue);
      res = await _dio.get(_url);
    }
    Picture.add(getValue);
    print(Picture[0].length);
    print(Picture[0]);
    cloop.add(Picture[cl].length);
    cl++;
    return getValue;
  }

  List<List<String>> Picture = [];

  int cl = 0;
  List<int> cloop = [];
  HomeBloc _homeBloc;

  @override
  Widget build(BuildContext context) {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    final _updateName = TextEditingController();
    final _updateFName = TextEditingController();
    return Scaffold(
      body: FutureBuilder<List<String>>(
          future: fetchMyModel(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BlocConsumer<HomeBloc, HomeState>(
                listener: (BuildContext context, HomeState state) {},
                builder: (BuildContext context, HomeState state) {
                  ///// MainScreen
                  if (state is InitialHomeState) {
                    return Container(
                      margin: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Senna Sims',
                            textScaleFactor: 2,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 1,
                            height: (MediaQuery.of(context).size.height * 0.8),
                            child: ListView.builder(
                              itemCount: state.countFamily + 1,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                if (index < state.countFamily) {
                                  return Container(
                                    margin: const EdgeInsets.all(8.0),
                                    width: (MediaQuery.of(context).size.width *
                                        0.8),
                                    height:
                                        (MediaQuery.of(context).size.height *
                                            1),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 2)),
                                    child: ListView(
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.close,
                                                color: Colors.red),
                                            onPressed: () {
                                              _homeBloc.add(delEvent(
                                                  state.Family[index]));
                                              Picture.removeAt(index);
                                            },
                                            alignment: Alignment.topRight),
                                        Text('${state.Family[index][0]}',
                                            textScaleFactor: 2,
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold)),
                                        for (int i = 0;
                                            i < Picture[index].length;
                                            i++)
                                          _showFamily(
                                              context,
                                              state.Family[index][i + 1],
                                              Picture[index][i])
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container(
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    width: (MediaQuery.of(context).size.width *
                                        0.85),
                                    height:
                                        (MediaQuery.of(context).size.height *
                                            0.85),
                                    child: TextButton(
                                      onPressed: () {
                                        _homeBloc.add(AddFamilyEvent());
                                      },
                                      child: Text(
                                        ' + Add new family',
                                        textScaleFactor: 2,
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  ///// Loding
                  else if (state is LoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is AddFamilyState) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        //mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: (MediaQuery.of(context).size.height *
                                    (0.25 / 4)),
                                alignment: Alignment.topRight,
                                decoration: BoxDecoration(
                                  color: Colors.blue[200],
                                  border: Border.all(
                                    color: Colors.blue[600],
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: InkWell(
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                          color: Colors.blue[600],
                                          fontSize: 26),
                                    ),
                                    onTap: () {
                                      Picture.add(state.picture);
                                      cloop.add(Picture[cl].length);
                                      cl++;
                                      _homeBloc.add(updateFamilyEvent(
                                          _updateFName.text,
                                          state.name,
                                          state.picture));
                                      _updateFName.text = '';
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'SennaSims ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32),
                              ),
                              Text('Create new sims',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text('Family name : ',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 22))),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: TextField(
                                    controller: _updateFName,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 1,
                            height: (MediaQuery.of(context).size.height * 0.7),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.countMember,
                              itemBuilder: (_, i) {
                                if (i < (state.countMember - 1)) {
                                  return Container(
                                    margin: const EdgeInsets.all(8.0),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    height: MediaQuery.of(context).size.height *
                                        0.85,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.close,
                                              color: Colors.red),
                                          alignment: Alignment.topRight,
                                          onPressed: () {
                                            _homeBloc.add(delMemberEvent(i));
                                          },
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            '${state.picture[i]}'),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(15),
                                                      ),
                                                    ),
                                                  )),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '  ' + state.name[i],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Adress',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                state.adress[i],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Company',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(state.ncompany[i],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey)),
                                              Text(state.company[i],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container(
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    height: MediaQuery.of(context).size.height *
                                        0.85,
                                    child: TextButton(
                                      onPressed: () {
                                        _homeBloc.add(AddMemberEvent());
                                      },
                                      child: Text(
                                        ' + Add new member',
                                        textScaleFactor: 2,
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is AddMemberState) {
                    return Container(
                      margin: const EdgeInsets.all(12),
                      child: ListView(
                        //mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(12),
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: (MediaQuery.of(context).size.height *
                                    (0.25 / 4)),
                                alignment: Alignment.topRight,
                                decoration: BoxDecoration(
                                  color: Colors.blue[200],
                                  border: Border.all(
                                    color: Colors.blue[600],
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      print(state.i);
                                      print(state.j);
                                      _homeBloc.add(updateMemberEvent(
                                          _updateName.text,
                                          state.i,
                                          state.j,
                                          state.k));
                                      _updateName.text = '';
                                    },
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                          color: Colors.blue[600],
                                          fontSize: 26),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'SennaSims ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32),
                              ),
                              Text('Create new family member',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16)),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 30),
                            width: MediaQuery.of(context).size.width * 1,
                            height: (MediaQuery.of(context).size.height * 0.75),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          Text('name '),
                                          Star,
                                          Text(' :'),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: TextField(
                                          controller: _updateName,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          Text('address '),
                                          Star,
                                          Text(' :'),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: DropdownButton(
                                          value: state.i,
                                          icon: Icon(Icons.keyboard_arrow_down),
                                          isExpanded: true,
                                          onChanged: (String newValue) {
                                            state.i = newValue;
                                            _homeBloc.emit(AddMemberState(
                                                state.i,
                                                state.j,
                                                state.k,
                                                state.adress,
                                                state.company,
                                                state.piture));
                                          },
                                          items:
                                              state.adress.map((String items) {
                                            return DropdownMenuItem(
                                                value: items,
                                                child: Text(items));
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            Text('company '),
                                            Star,
                                            Text(' :'),
                                          ],
                                        )),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: DropdownButton(
                                          isExpanded: true,
                                          value: state.j,
                                          icon: Icon(Icons.keyboard_arrow_down),
                                          onChanged: (String newValue) {
                                            state.j = newValue;
                                            _homeBloc.emit(AddMemberState(
                                                state.i,
                                                state.j,
                                                state.k,
                                                state.adress,
                                                state.company,
                                                state.piture));
                                          },
                                          items: state.company.map(
                                            (String items) {
                                              return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items));
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            Text('profile '),
                                            Star,
                                            Text(' :'),
                                          ],
                                        )),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        width:
                                            (MediaQuery.of(context).size.width *
                                                0.25),
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height *
                                            (0.25 / 4)),
                                        alignment: Alignment.topRight,
                                        decoration: BoxDecoration(
                                          color: Colors.blue[200],
                                          border: Border.all(
                                            color: Colors.blue[600],
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: InkWell(
                                            child: Text(
                                              'Select image',
                                              style: TextStyle(
                                                  color: Colors.blue[600],
                                                  fontSize: 26),
                                            ),
                                            onTap: () => showDialog<void>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text(
                                                    'Select profile image'),
                                                contentPadding: EdgeInsets.zero,
                                                content: Row(
                                                  children: [
                                                    for (int i = 1; i <= 3; i++)
                                                      Expanded(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: FlatButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              state.k = state
                                                                  .piture[i];
                                                              print(state.k);
                                                              _homeBloc.emit(
                                                                  AddMemberState(
                                                                      state.i,
                                                                      state.j,
                                                                      state.k,
                                                                      state
                                                                          .adress,
                                                                      state
                                                                          .company,
                                                                      state
                                                                          .piture));
                                                            },
                                                            child: Image
                                                                .network(state
                                                                        .piture[
                                                                    i])),
                                                      )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _showFamily(BuildContext context, String _getName, String _getPic) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: (_getPic != '')
                        ? NetworkImage('${_getPic}')
                        : NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQt4JUUYGbQVSYydzwVC9Rx1j6BcMY9shkYgQ&usqp=CAU'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 2,
            child: Text(
              '$_getName',
              textScaleFactor: 2,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget Star = Text(
    '*',
    style: TextStyle(color: Colors.red),
  );
}
