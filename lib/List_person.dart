class Person {
  String? id;
  String? name;
  String? lastName;
  String? address;
  String? dateOfBirth;
  String? dateOfAdmission;
  int? salary;

  Person({
    this.id,
    this.name,
    this.lastName,
    this.address,
    this.dateOfBirth,
    this.dateOfAdmission,
    this.salary,
  });

  Person.fromJson(Map<String, dynamic> jsonPerson) {
    id = jsonPerson['id'];
    name = jsonPerson['name'];
    lastName = jsonPerson['lastName'];
    address = jsonPerson['address'];
    dateOfBirth = jsonPerson['dateOfBirth'];
    dateOfAdmission = jsonPerson['dateOfAdmission'];
    salary = jsonPerson['salary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['address'] = this.address;
    data['dateOfBirth'] = this.dateOfBirth;
    data['dateOfAdmission'] = this.dateOfAdmission;
    data['salary'] = this.salary;

    return data;
  }
}
