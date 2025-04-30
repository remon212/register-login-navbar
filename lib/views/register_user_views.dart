import 'package:flutter/material.dart';
import 'package:movie/services/user.dart';
import 'package:movie/widgets/alert.dart';

class RegisterUserView extends StatefulWidget {
  const RegisterUserView({Key? key});

  @override
  State<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {
  final formKey = GlobalKey<FormState>();
  final UserService user = UserService();
  bool isLoading = false;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController birthday = TextEditingController();
  List roleChoice = ["admin", "kasir"];
  String? role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register User"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Text(
                "Register User",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(label: Text("Name")),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nama harus diisi';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(label: Text("Email")),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email harus diisi';
                        } else {
                          return null;
                        }
                      },
                    ),
                    DropdownButtonFormField(
                      isExpanded: true,
                      value: role,
                      items: roleChoice.map((r) {
                        return DropdownMenuItem(value: r, child: Text(r));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          role = value.toString();
                        });
                      },
                      hint: Text("Pilih role"),
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return 'Role harus dipilih';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: password,
                      decoration: InputDecoration(label: Text("Password")),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password harus diisi';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: address,
                      decoration: InputDecoration(label: Text("Address")),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Address harus diisi';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: birthday,
                      decoration: InputDecoration(label: Text("Birthday")),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Birthday harus diisi';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  var data = {
                                    "name": name.text,
                                    "email": email.text,
                                    "role": role,
                                    "password": password.text,
                                    "address": address.text,
                                    "birthday": birthday.text,
                                  };
                                  var result = await user.registerUser(data);
                                  print("Hasil register: $result");
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (result.status == true) {
                                    name.clear();
                                    email.clear();
                                    password.clear();
                                    address.clear();
                                    birthday.clear();
                                    setState(() {
                                      role = null;
                                    });
                                    AlertMessage().showAlert(
                                        context, result.message, true);
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      Navigator.pushReplacementNamed(
                                          context, '/login');
                                    });
                                  } else {
                                    AlertMessage().showAlert(
                                        context, result.message, false);
                                  }
                                } catch (e, stack) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  print("Error register: $e");
                                  print(stack);
                                  AlertMessage().showAlert(
                                      context, "Terjadi error: $e", false);
                                }
                              }
                            },
                      child: isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text("Register"),
                      color: Colors.lightGreen,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
