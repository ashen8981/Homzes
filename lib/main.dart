import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homzes_app/presentation/blocs/navigation_bloc.dart';
import 'package:homzes_app/presentation/blocs/property_cubit.dart';
import 'core/routes/app_routes.dart';
import 'data/repositories/property_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => PropertyCubit(PropertyRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Homzes App',
        initialRoute: Routes.welcome,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
