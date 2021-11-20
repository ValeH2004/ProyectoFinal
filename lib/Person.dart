import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'Edit_Person.dart';
import 'List_person.dart';
import 'Create_Person.dart';

class Users extends StatefulWidget {
  Users({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<Person> listPersons = [];

  @override
  void initState() {
    super.initState();
    callServiceGetListPersons();
    print(listPersons);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Colors.deepOrangeAccent,
                Colors.deepPurpleAccent,
                Colors.lightBlueAccent,
              ])),
        ),
        title: Text('EMPLEADOS DE SOFKA'),
      ),
      body: listPersons.isNotEmpty
          ? Container(
              child: ListView.builder(
                itemCount: listPersons.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4.0,
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                    child: ListTile(
                      leading: IconButton(
                        icon: const Icon(Icons.account_circle_outlined),
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Información Personal'),
                            content: Padding(
                              padding: EdgeInsets.symmetric(vertical: 100),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nombre: ${listPersons[index].name!}',
                                  ),
                                  Text(
                                      'Apellido: ${listPersons[index].lastName!}'),
                                  Text(
                                      'Dirección: ${listPersons[index].address!}'),
                                  Text(
                                      'Fecha de nacimiento: ${listPersons[index].dateOfBirth!}'),
                                  Text(
                                      'Fecha de ingreso: ${listPersons[index].dateOfAdmission!}'),
                                  Text(
                                      'Salario: ${listPersons[index].salary ?? 0}'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 125, vertical: 55),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Salir'),
                                      child: const Text('Salir'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        callEditListPersons(
                                            listPersons[index].id!);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => EditEmpleado(
                                                    listPersons[index])));
                                      },
                                      child: Text('Editar'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Eliminar empleado'),
                              content: const Text(
                                  '¿Seguro que quieres eliminar definitivamente este empleado?'),
                              actions: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 125),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancelar'),
                                        child: Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          callDeleteListPersons(
                                              listPersons[index].id!);
                                          SnackBar snackBar = SnackBar(
                                            content: Text(
                                                "Persona Eliminada :  ${listPersons[index].name} ${listPersons[index].lastName}"),
                                            backgroundColor: Colors.blueGrey,
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          setState(() {
                                            listPersons.removeAt(index);
                                            Navigator.pop(context, 'Eliminar');
                                          });
                                        },
                                        child: Text('Eliminar'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      title: Text(
                          '${listPersons[index].name!} ${listPersons[index].lastName!}'),
                    ),
                  );
                },
              ),
            )
          : Center(
              child: Text('surgio un error'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => callCreatePersonPage(),
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }

  callCreatePersonPage() {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => CreatePersonPage()))
        .then((value) {
      if (value) {
        callServiceGetListPersons();
      }
    });
  }

  callServiceGetListPersons() async {
    var url =
        Uri.parse('https://617d6e1b1eadc5001713652d.mockapi.io/Empleado2');
    Response response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      listPersons = (jsonDecode(response.body) as List).map((personJson) {
        return Person.fromJson(personJson);
      }).toList();

      setState(() {});
    } else {
      print('Hubo un error');
    }
  }

  callDeleteListPersons(String id) async {
    var url =
        Uri.parse('https://617d6e1b1eadc5001713652d.mockapi.io/Empleado2/$id');
    Response response = await http.delete(url);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      setState(() {
        callServiceGetListPersons();
      });
    } else {
      print('Hubo un error');
    }
  }
  callEditListPersons(String id) async {
    var url =
    Uri.parse('https://617d6e1b1eadc5001713652d.mockapi.io/Empleado2/$id');
    Response response = await http.put(url);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      setState(() {
        callServiceGetListPersons();
      });
    } else {
      print('Hubo un error');
    }
  }
}
