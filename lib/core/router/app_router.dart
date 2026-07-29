import 'package:autolog/features/cars/screens/add_car_screen.dart';
import 'package:autolog/features/cars/screens/car_dashboard_screen.dart';
import 'package:autolog/features/cars/screens/home_screen.dart';
import 'package:autolog/features/expenses/screens/expense_history_screen.dart';
import 'package:autolog/features/fuel/screens/add_fuel_screen.dart';
import 'package:autolog/features/fuel/screens/fuel_screen.dart';
import 'package:autolog/features/reminders/models/reminder.dart';
import 'package:autolog/features/reminders/screens/add_reminder_screen.dart';
import 'package:autolog/features/reminders/screens/edit_reminder_screen.dart';
import 'package:autolog/features/reminders/screens/reminder_screen.dart';
import 'package:autolog/features/service/models/service_record.dart';
import 'package:autolog/features/service/screens/add_service_screen.dart';
import 'package:autolog/features/service/screens/edit_service_screen.dart';
import 'package:autolog/features/service/screens/service_history_screen.dart';
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
      path: "/service/edit",

      builder: (context, state) {
        final service = state.extra as ServiceRecord;

        return EditServiceScreen(service: service);
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
    GoRoute(
      path: '/fuel/:carId',

      builder: (context, state) {
        final carId = state.pathParameters['carId']!;

        return FuelScreen(carId: carId);
      },
    ),
    GoRoute(
      path: '/fuel/:carId/add',

      builder: (context, state) {
        final carId = state.pathParameters['carId']!;

        return AddFuelScreen(carId: carId);
      },
    ),
    GoRoute(
      path: "/reminder/edit",
      builder: (context, state) {
        final reminder = state.extra as Reminder;

        return EditReminderScreen(carId: reminder.carId, reminder: reminder);
      },
    ),
    GoRoute(
      path: "/reminder/:carId",

      builder: (context, state) {
        return ReminderScreen(carId: int.parse(state.pathParameters['carId']!));
      },
    ),

    GoRoute(
      path: '/reminder/:carId/add',
      builder: (context, state) {
        return AddReminderScreen(
          carId: int.parse(state.pathParameters['carId']!),
        );
      },
    ),

    GoRoute(
      path: '/service/:carId/history',
      builder: (context, state) {
        return ServiceHistoryScreen(carId: state.pathParameters['carId']!);
      },
    ),

    GoRoute(
      path: '/expenses/:carId/history',

      builder: (context, state) {
        return ExpenseHistoryScreen(carId: state.pathParameters['carId']!);
      },
    ),
  ],
);
