import 'package:autolog/features/cars/screens/add_car_screen.dart';
import 'package:autolog/features/cars/screens/car_dashboard_screen.dart';
import 'package:autolog/features/cars/screens/home_screen.dart';
import 'package:autolog/features/service/screens/add_service_screen.dart';
import 'package:autolog/features/service/screens/service_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),

    GoRoute(
      path: '/add-car',
      builder: (context, state) => const AddCarScreen(),
    ),
    GoRoute(
      path: '/car/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return CarDashboardScreen(carId: id);
      },
    ),
    GoRoute(
      path: '/service/:carId',

      builder: (context, state) {
        final carId = state.pathParameters['carId']!;

        return ServiceScreen(carId: carId);
      },
    ),
    GoRoute(
      path: '/service/:carId/add',

      builder: (context, state) {
        final carId = state.pathParameters['carId']!;

        return AddServiceScreen(carId: carId);
      },
    ),
  ],
);
