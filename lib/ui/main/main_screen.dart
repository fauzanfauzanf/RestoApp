import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resto_app/model/resto.dart';
import 'package:resto_app/ui/main/bloc/bloc.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  MainBloc _mainBloc;

  @override
  void initState() {
    _permission();
    _mainBloc = new MainBloc();
    _mainBloc.dispatch(LoadResto());
    super.initState();
  }

  _permission() async {
    await PermissionHandler().requestPermissions([PermissionGroup.location]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            'RestoApp',
            style: TextStyle(
              color: Colors.green
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: BlocBuilder(
          bloc: _mainBloc,
          builder: (context, state){
            if (state is LoadingResto) {
              return _viewLoading();
            }
            if (state is SuccessLoadResto){
              return _viewBody(state.resto);
            }

            if (state is ErrorLoadResto){
              return _viewError();
            }

            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            );
          },
        ),
      ),
    );
  }

  Widget _viewLoading(){
    return Center(
      child: SpinKitRing(
        color: Colors.grey,
        size: 25.0,
        lineWidth: 2.0,
      ),
    );
  }

  Widget _viewBody(Resto resto){
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: (){
          _mainBloc.dispatch(LoadResto());
        },
        child: ListView.builder(
            itemCount: resto.results.length,
            itemBuilder: (ctx, index){
              var item = resto.results[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        item.name
                      ),
                      subtitle: Text(
                        item.vicinity
                      ),
                      trailing: Container(
                        width: 50,
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              item.rating.toString()
                            )
                          ],
                        ),
                      ),
                    )
                  )
                ),
              );
            }
        ),
      ),
    );
  }

  Widget _viewError(){
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Tidak dapat mengambil data"),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: (){
                _mainBloc.dispatch(LoadResto());
              },
            )
          ],
        ),
      ),
    );
  }
}
