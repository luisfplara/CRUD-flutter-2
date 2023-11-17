import 'dart:ui';

import 'package:crud_confere/models/products.dart';
import 'package:crud_confere/myhomepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bloc/myhomepage_bloc.dart';
import 'models/sizes.dart';

enum dialog { Add, View, Edit }

class CustomDialogBox extends StatefulWidget {
  final Products products;

  final MyHomePageBloc bloc;
  final String propose;

  const CustomDialogBox(
      {Key? key,
      required this.products,
      required this.bloc,
      required this.propose})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() =>
      _CustomDialogBoxState(products: products, bloc: bloc, propose: propose);
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  Products products;
  MyHomePageBloc bloc;
  String propose;
  int? index;
  _CustomDialogBoxState(
      {required this.products,
      required this.bloc,
      required this.propose,
      this.index});

  MyHomePage MHP = MyHomePage();
  final _nome = new TextEditingController();
  final _preco = new TextEditingController();
  final _estilo = new TextEditingController();
  final _codcor = new TextEditingController();
  final _slug = new TextEditingController();
  final _cor = new TextEditingController();
  final _precoPromo = new TextEditingController();
  final _disconto = new TextEditingController();
  final _parcelas = new TextEditingController();
  final _image = new TextEditingController();
  final _sku = new TextEditingController();

  bool _isPromo = false;

  bool p = false;
  bool pp = false;
  bool m = false;
  bool g = false;
  bool gg = false;

  bool _validateNome = false;
  bool _validatePreco = false;
  bool _initialFill = true;

  @override
  Widget build(BuildContext context) {
    print("buildo dnv");

    if (_initialFill && this.propose == 'Editar') {
      this._nome.text = products.name!;
      this._preco.text = products.regularPrice!;
      this._estilo.text = products.style!;
      this._codcor.text = products.codeColor!;
      this._slug.text = products.colorSlug!;
      this._cor.text = products.color!;
      this._precoPromo.text = products.actualPrice!;
      this._disconto.text = products.discountPercentage!;
      this._parcelas.text = products.installments!;
      this._image.text = products.image!;
      this._sku.text = products.sizes![0].sku!;
      
      pp = products.sizes![0].available!;
      p = products.sizes![1].available!;
      m = products.sizes![2].available!;
      g = products.sizes![3].available!;
      gg = products.sizes![4].available!;
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ]),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.blue[50],
                radius: 45,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  child: _image.text.isEmpty
                      ? Container(
                          child: Text("Sem Imagem",
                              style: TextStyle(fontSize: 13)),
                        )
                      : Image(
                          image: NetworkImage(products.image!),
                        ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _nome,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                  errorText: _validateNome ? 'Campo necessário' : null,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _preco,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Preço',
                  errorText: _validatePreco ? 'Campo necessário' : null,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _estilo,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Estilo',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _codcor,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Codigo de cor',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _slug,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Slug',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _cor,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cor',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Promoção"),
                        Switch(
                          value: _isPromo,
                          onChanged: (value) {
                            _initialFill = false;
                            setState(() {
                              _isPromo = value;
                              print(_isPromo);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _isPromo,
                    child: Column(
                      children: [
                        TextField(
                          controller: _precoPromo,
                          decoration: InputDecoration(
                            fillColor: Colors.blue[50],
                            filled: true,
                            border: OutlineInputBorder(),
                            labelText: 'Preço promoção',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: _disconto,
                          decoration: InputDecoration(
                            fillColor: Colors.blue[50],
                            filled: true,
                            border: OutlineInputBorder(),
                            labelText: 'Disconto %',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _image,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Imagem URL',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _parcelas,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Parcelas',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              StatefulBuilder(
                // StatefulBuilder
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("PP"),
                          Checkbox(
                            value: pp,
                            onChanged: (bool? value) {
                              // print(value);
                              setState(() {
                                print(pp);
                                pp = value!;
                              });
                            },
                          ),
                          Text("P"),
                          Checkbox(
                            value: p,
                            onChanged: (bool? value) {
                              // print(value);
                              setState(() {
                                p = value!;
                              });
                            },
                          ),
                          Text("M"),
                          Checkbox(
                            value: m,
                            onChanged: (bool? value) {
                              // print(value);
                              setState(() {
                                m = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("G"),
                          Checkbox(
                            value: g,
                            onChanged: (bool? value) {
                              // print(value);
                              setState(() {
                                g = value!;
                              });
                            },
                          ),
                          Text("GG"),
                          Checkbox(
                            value: gg,
                            onChanged: (bool? value) {
                              // print(value);
                              setState(() {
                                gg = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _sku,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'SKU',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  Products produtos = Products();

                  produtos.name = _nome.text;
                  produtos.style = _estilo.text;
                  produtos.codeColor = _codcor.text;
                  produtos.colorSlug = _slug.text;
                  produtos.color = _cor.text;
                  produtos.onSale = _isPromo;
                  produtos.regularPrice = _preco.text;
                  produtos.actualPrice = _precoPromo.text;
                  produtos.discountPercentage = _disconto.text;
                  produtos.installments = _parcelas.text;
                  produtos.image = _image.text;

                  List<Sizes> s = [
                    Sizes(
                      available: pp,
                      size: "PP",
                      sku: _sku.text,
                    ),
                    Sizes(
                      available: p,
                      size: "P",
                      sku: _sku.text,
                    ),
                    Sizes(
                      available: m,
                      size: "M",
                      sku: _sku.text,
                    ),
                    Sizes(
                      available: g,
                      size: "G",
                      sku: _sku.text,
                    ),
                    Sizes(
                      available: gg,
                      size: "GG",
                      sku: _sku.text,
                    )
                  ];

                  produtos.sizes = s;

                  print(index);
                  if (products.index != null) {
                    await bloc.DeletProducts(products.index!);
                  }else{

                     ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Produto Inserido'),
                    
                  ),
                );
                  }


                  await bloc.InsertProducts(produtos);

                  await bloc.ReadJsonData();
                  setState(() {
                    bloc.ReadJsonData();
                  });

                  if (_nome.text.isEmpty == true ||
                      _preco.text.isEmpty == true) {
                    setState(() {
                      _nome.text.isEmpty
                          ? _validateNome = true
                          : _validateNome = false;
                      _preco.text.isEmpty
                          ? _validatePreco = true
                          : _validatePreco = false;
                    });
                  } else {
                    Navigator.pop(context, true);
                  }
                },
                child: Text(this.propose),
              ),
              SizedBox(
                height: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
