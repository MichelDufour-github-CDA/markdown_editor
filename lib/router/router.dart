import 'package:go_router/go_router.dart';
import 'package:markdown_editor/presentation/pages/home_page.dart';
import 'package:markdown_editor/presentation/pages/preview_page.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        name: HomePage.name,
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        name: PreviewPage.name,
        path: '/preview',
        builder: (context, state) => const PreviewPage(),
      ),
    ],
  );
}
