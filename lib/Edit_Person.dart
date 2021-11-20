import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'List_person.dart';
import 'Person.dart';

class EditEmpleado extends StatefulWidget {
  final Person _person;

  EditEmpleado(this._person);

  @override
  _EditEmpleadoState createState() => _EditEmpleadoState();
}

class _EditEmpleadoState extends State<EditEmpleado> {
  TextEditingController? textEditingControllerName;
  TextEditingController? textEditingControllerLastname;
  TextEditingController? textEditingControllerAddress;
  TextEditingController? textEditingControllerDateofbirth;
  TextEditingController? textEditingControllerDateofadmission;
  TextEditingController? textEditingControllerSalary;

  @override
  void initState() {
    super.initState();
    Person p = widget._person;
    textEditingControllerName = TextEditingController(text: p.name);
    textEditingControllerLastname = TextEditingController(text: p.lastName);
    textEditingControllerAddress = TextEditingController(text: p.address);
    textEditingControllerDateofbirth = TextEditingController(text: p.dateOfBirth);
    textEditingControllerDateofadmission = TextEditingController(text: p.dateOfAdmission);
    textEditingControllerSalary = TextEditingController(text: p.salary.toString());
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
                    Colors.lightBlueAccent,
                    Colors.greenAccent,
                  ])),
        ),
        title: Text(
          'Editar Persona',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          child: ListView(
            children: [
              Column(
                children: [
                  TextField(
                    controller: textEditingControllerName,
                    autofocus: false,
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      labelText: "Nombre",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    controller: textEditingControllerLastname,
                    autofocus: false,
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      labelText: "Apellido",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    controller: textEditingControllerAddress,
                    autofocus: false,
                    keyboardType: TextInputType.streetAddress,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      labelText: "Dirección",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    controller: textEditingControllerDateofbirth,
                    autofocus: false,
                    keyboardType: TextInputType.datetime,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      labelText: "Fecha de nacimiento",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    controller: textEditingControllerDateofadmission,
                    autofocus: false,
                    keyboardType: TextInputType.datetime,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      labelText: "Fecha de ingreso",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    controller: textEditingControllerSalary,
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      labelText: "Salario",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (fieldsNotEmpty()) {
                        callServiceEditPerson(EditPerson());
                      }
                      String name = textEditingControllerName!.text;
                      String lastname = textEditingControllerLastname!.text;
                      String address = textEditingControllerAddress!.text;
                      String dateOfBirth =
                          textEditingControllerDateofbirth!.text;
                      String dateOfAdmission =
                          textEditingControllerDateofadmission!.text;
                      String salary = textEditingControllerSalary!.text;

                      if (name.isNotEmpty &&
                          lastname.isNotEmpty &&
                          address.isNotEmpty &&
                          dateOfBirth.isNotEmpty &&
                          dateOfAdmission.isNotEmpty &&
                          salary.isNotEmpty) {
                        Navigator.pop(
                            context,
                            new Person(
                                name: name,
                                lastName: lastname,
                                address: address,
                                dateOfBirth: dateOfBirth,
                                dateOfAdmission: dateOfAdmission));
                      }
                    },
                    child: Text("Guardar Persona"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void callServiceEditPerson(Person person) async {
    var url =
    Uri.parse('https://617d6e1b1eadc5001713652d.mockapi.io/Empleado2');
    var personBody = jsonEncode(person);

    Response response = await http.put(
      url,
      body: personBody,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      Navigator.pop(context, true);
    } else {
      print('Hubo un error');
    }
  }

  bool fieldsNotEmpty() {
    return textEditingControllerName!.text.isNotEmpty &&
        textEditingControllerLastname!.text.isNotEmpty &&
        textEditingControllerAddress!.text.isNotEmpty &&
        textEditingControllerDateofbirth!.text.isNotEmpty &&
        textEditingControllerDateofadmission!.text.isNotEmpty &&
        textEditingControllerSalary!.text.isNotEmpty;
  }

  Person EditPerson() {
    return Person(
        name: textEditingControllerName!.text,
        lastName: textEditingControllerLastname!.text,
        address: textEditingControllerAddress!.text,
        dateOfBirth: textEditingControllerDateofbirth!.text,
        dateOfAdmission: textEditingControllerDateofadmission!.text);
  }
}