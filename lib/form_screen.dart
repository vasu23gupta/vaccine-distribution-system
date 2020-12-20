import 'package:flutter/material.dart';
import 'constants.dart';
import 'database_service.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = '';
  List<TextEditingController> textEditingController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  List<String> genders = ['Female', 'Male', 'Other'];
  List<String> yesno = ['Yes', 'No'];
  String covideb4yesno;
  String medcondyesno;

  String name = '';
  String gender;
  int age = 0;
  int pincode = 0;
  bool medCond; //asthma, diabetes etc
  String email = '';
  int phone = 0;
  bool covidB4; //infected with covid before?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vaccine Distribution System'),
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                //name:
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: textEditingController[0],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Name",
                  ),
                  validator: (val) => val.isEmpty ? 'Enter your name' : null,
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                ),
                //gender
                SizedBox(
                  height: 12.0,
                ),
                DropdownButton(
                  isExpanded: true,
                  hint: Text('Gender'),
                  dropdownColor: Colors.white,
                  elevation: 1,
                  value: gender,
                  onChanged: (value) {
                    setState(
                      () {
                        gender = value;
                      },
                    );
                  },
                  items: genders.map(
                    (e) {
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    },
                  ).toList(),
                ),
                //age
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: textEditingController[1],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Age",
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter your age';
                    }
                    if (int.tryParse(val) == null) {
                      return 'Enter proper age';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() => age = int.parse(val));
                  },
                ),
                //pincode
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: textEditingController[2],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Pincode",
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter your pincode';
                    }
                    if (int.tryParse(val) == null || val.length != 6) {
                      return 'Enter proper pincode';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() => pincode = int.parse(val));
                  },
                ),
                //email
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: textEditingController[3],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "E-mail",
                  ),
                  validator: (val) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val)
                        ? null
                        : "Enter valid email address";
                  },
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                //phone
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: textEditingController[4],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Mobile Number",
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter your Mobile number';
                    }
                    if (int.tryParse(val) == null || val.length != 10) {
                      return 'Enter proper Mobile number';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() => phone = int.parse(val));
                  },
                ),
                //medCond
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Do you have existing medical conditions like asthma, diabetes, blood pressure, or heart diseases?',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                DropdownButton(
                  isExpanded: true,
                  hint: Text('Yes/No'),
                  value: medcondyesno,
                  onChanged: (value) {
                    setState(
                      () {
                        if (value == 'Yes') {
                          medCond = true;
                        } else if (value == 'No') {
                          medCond = false;
                        }
                        medcondyesno = value;
                      },
                    );
                  },
                  items: yesno.map(
                    (e) {
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    },
                  ).toList(),
                ),
                //covidB4
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Have you ever been infected with COVID-19?',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                DropdownButton(
                  isExpanded: true,
                  hint: Text('Yes/No'),
                  value: covideb4yesno,
                  onChanged: (value) {
                    setState(
                      () {
                        if (value == 'Yes') {
                          covidB4 = true;
                        } else if (value == 'No') {
                          covidB4 = false;
                        }
                        covideb4yesno = value;
                      },
                    );
                  },
                  items: yesno.map(
                    (e) {
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    },
                  ).toList(),
                ),

                //submit button:
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate() &&
                        covidB4 != null &&
                        medCond != null &&
                        gender != null) {
                      print(name);
                      print(gender);
                      print(age);
                      print(pincode);
                      print(email);
                      print(phone);
                      print(medCond);
                      print(covidB4);
                      ApplicationDatabaseService().updateUserData(name, gender,
                          age, pincode, medCond, email, phone, covidB4);
                      setState(() {
                        error = 'Form submitted!';
                        for (var item in textEditingController) {
                          item.clear();
                        }
                      });
                    } else {
                      setState(() {
                        error =
                            'Please check if all the fields have been filled correcly';
                      });
                    }
                  },
                ),
                //error text:
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
