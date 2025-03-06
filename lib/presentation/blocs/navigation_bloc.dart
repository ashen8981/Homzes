import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homzes_app/core/routes/app_routes.dart';

class NavigationBloc extends Cubit<String> {
  NavigationBloc() : super(Routes.welcome);

  void navigateTo(String route) => emit(route);
}
