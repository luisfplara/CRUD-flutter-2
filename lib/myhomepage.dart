
import 'dart:ui';
import 'package:crud_confere/bloc/myhomepage_bloc.dart';
import 'package:crud_confere/models/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';


import 'CustomDialog.dart';
import 'models/db.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyHomePageBloc bloc = MyHomePageBloc();
  @override
  void initState() {
/*
 bloc.loaddb() é usado Para carregar o banco de dados com as insformações já fornecidas, é necessário executar uma única 
 o comando  bloc.loaddb() para gerar um arquivo interno do aplicativo que é uma réplica do asset db.json e ficará armazenado
 os novos produtos manipualdos, fiz isso pois arquivos não podem ser alterados no assets e para manter a base dada por vocês.
  Execute uma vez bloc.loaddb() depois comente essa linha. 
*/
    bloc.loaddb();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(body:  
    Material(
      child: StreamBuilder(
        stream: bloc.listStream,
        initialData: bloc.ReadJsonData(),
        builder: (context, snapshot) {
          Db items = bloc.db;

          if (snapshot.connectionState != ConnectionState.waiting) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    floating: true,
                    expandedHeight: 50.0,
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Text('CRUD Confere', textAlign: TextAlign.right),
                    ),
                    actions: [
                      Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialogBox(
                                      products: new Products(),
                                      key: widget.key,
                                      bloc: bloc,
                                      propose: 'Adicionar',
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                Text("Add"),
                                Icon(
                                  Icons.add_box,
                                  size: 26.0,
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        var products = items.products;

                        return Container(
                          color: Colors.white,
                          height: 100.0,
                          child: Slidable(
                            direction: Axis.horizontal,
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    child: products![index]
                                            .image
                                            .toString()
                                            .isNotEmpty
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image(
                                              image: NetworkImage(items
                                                  .products![index].image
                                                  .toString()),
                                              fit: BoxFit.fill,
                                            ))
                                        : Text(
                                            "Sem imagem",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Text(
                                              items.products![index].name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: Text(items
                                                    .products![index]
                                                    .regularPrice!),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: items
                                                        .products![index].onSale
                                                    ? Text("Promoção " +
                                                        items.products![index]
                                                            .actualPrice!)
                                                    : null,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_left,
                                    color: Colors.blue[100],
                                    size: 24.0,
                                    semanticLabel:
                                        'Text to announce in accessibility modes',
                                  ),
                                ],
                              ),
                            ),
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                caption: 'Editar',
                                color: Colors.blue,
                                icon: Icons.edit,
                                onTap: () {
                                  print(index);
                                  products[index].index = index;
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialogBox(
                                          products: products[index],
                                          key: widget.key,
                                          bloc: bloc,
                                          propose: 'Editar',
                                        );
                                      });
                                },
                              ),
                              IconSlideAction(
                                caption: 'Deletar',
                                color: Colors.indigo,
                                icon: Icons.delete,
                                onTap: () async {
                                  print(index);

                                  showAlertDialog(context, index);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: items == null ? 0 : items.products!.length,
                    ),
                  ),
                ],
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    )
   ,);
  
  
  }

  showAlertDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Excluir item"),
          content: Text("Deseja excluir o produto?"),
          actions: [
            TextButton(
              child: Text("Sim"),
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Deletado com sucesso'),
                    
                  ),
                );
                await bloc.DeletProducts(index);

                setState(() {
                  bloc.ReadJsonData();
                });

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Não"),
              onPressed: () {
                Navigator.of(context).pop(); // dismiss dialog
              },
            ),
          ],
        );
      },
    );
  }
}
