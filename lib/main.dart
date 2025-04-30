import 'package:flutter/material.dart';
import 'package:movie/views/register_user_views.dart';
import 'package:movie/views/login_view.dart';
import 'package:movie/views/dashboard_view.dart';
import 'package:movie/views/movie_view.dart';
import 'package:movie/views/pesan_view.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/': (context) => const RegisterUserView(),
      '/login': (context) => const LoginView(),
      '/dashboard': (context) => const DashboardView(),
      '/movie': (context) => const MovieView(),
      '/pesan': (context) => const PesanView(),
    },
  ));
}
