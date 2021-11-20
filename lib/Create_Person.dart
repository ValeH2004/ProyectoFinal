import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'List_person.dart';

class CreatePersonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreatePersonPageState();
  }
}

class CreatePersonPageState extends State<CreatePersonPage> {
  TextEditingController? textEditingControllerName;
  TextEditingController? textEditingControllerLastname;
  TextEditingController? textEditingControllerAddress;
  TextEditingController? textEditingControllerDateofbirth;
  TextEditingController? textEditingControllerDateofadmission;
  TextEditingController? textEditingControllerSalary;

  @override
  void initState() {
    super.initState();
    textEditingControllerName = TextEditingController();
    textEditingControllerLastname = TextEditingController();
    textEditingControllerAddress = TextEditingController();
    textEditingControllerDateofbirth = TextEditingController();
    textEditingControllerSalary = TextEditingController();
    textEditingControllerDateofadmission = TextEditingController();
  }

  @override
  void dispose() {
    textEditingControllerName!.dispose();
    textEditingControllerLastname!.dispose();
    textEditingControllerDateofbirth!.dispose();
    textEditingControllerDateofadmission!.dispose();
    textEditingControllerSalary!.dispose();
    super.dispose();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
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
                    callServiceCreatePerson(createPerson());
                  }
                },
                child: Text('Crear persona'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void callServiceCreatePerson(Person person) async {
    var url =
        Uri.parse('https://617d6e1b1eadc5001713652d.mockapi.io/Empleado2');
    var personBody = jsonEncode(person);

    Response response = await http.post(
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

  Person createPerson() {
    return Person(
        name: textEditingControllerName!.text,
        lastName: textEditingControllerLastname!.text,
        address: textEditingControllerAddress!.text,
        dateOfBirth: textEditingControllerDateofbirth!.text,
        dateOfAdmission: textEditingControllerDateofadmission!.text);
  }
}
