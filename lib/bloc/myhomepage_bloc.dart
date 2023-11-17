import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:crud_confere/models/products.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:path_provider/path_provider.dart';
import '../models/db.dart';
import 'package:crud_confere/models/db.dart';

class MyHomePageBloc {
  Db db = Db();
  final StreamController _streamController = StreamController();
  Sink get input => _streamController.sink;
  Stream get listStream => _streamController.stream;

  ReadJsonData() async {
    final file = await _localFile;
    final contents = json.decode(await file.readAsString());
    db = Db.fromJson(contents);
    
    input.add(db);
  }

  initData() async {
    final file = await _localFile;
    final contents = json.decode(await file.readAsString()) as dynamic;
    input.add(Db.fromJson(contents));
  }

  void loaddb() async {
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/db.json');


    InsertJsonData(Db.fromJson(jsonDecode(jsondata)));
  }

  Future<File> InsertJsonData(Db datab) async {
    final file = await _localFile;
       datab.products!.sort((a, b) {
                            return a.name
                                .toString()
                                .toLowerCase()
                                .compareTo(b.name.toString().toLowerCase());
                          });

    return file.writeAsString(jsonEncode(datab.toJson()));
  }

    InsertProducts(Products p) async {
    final file = await _localFile;
    final contents = json.decode(await file.readAsString()) as dynamic;
    db = Db.fromJson(contents);
      db.products!.add(p);
    db.products!.sort((a, b) {
                            return a.name
                                .toString()
                                .toLowerCase()
                                .compareTo(b.name.toString().toLowerCase());
                          });

                          
  
     file.writeAsString(jsonEncode(db));
  }

  DeletProducts (int index) async {
    final file = await _localFile;
    final contents = json.decode(await file.readAsString()) as dynamic;
    db = Db.fromJson(contents);
      print(db.products![index].name);
db.products!.removeAt(index);
   db.products!.sort((a, b) {
                            return a.name
                                .toString()
                                .toLowerCase()
                                .compareTo(b.name.toString().toLowerCase());
                          });
     file.writeAsString(jsonEncode(db));
  }


  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/db.json');
  }
}
