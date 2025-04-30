import 'package:flutter/material.dart';
import 'package:movie/models/user_login.dart';
import 'package:movie/widgets/bottom_nav.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  UserLogin userLogin = UserLogin();
  String? nama;
  String? role;

  getUserLogin() async {
    var user = await userLogin.getUserLogin();
    if (user.status != false) {
      setState(() {
        nama = user.nama_user;
        role = user.role;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text("Selamat Datang $nama role anda $role"),
      ),
      bottomNavigationBar: const BottomNav(0),
    );
  }
}
