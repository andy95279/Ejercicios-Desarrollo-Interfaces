import 'package:go_router/go_router.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/verify_screen.dart';
import '../screens/home_screen.dart';
import '../screens/chat/chat_select_screen.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/story_view_screen.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(path: '/verify', builder: (context, state) => const VerifyScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/chat-select',
      builder: (context, state) => const ChatSelectScreen(),
    ),
    GoRoute(
      path: '/chat/:id',
      builder: (context, state) =>
          ChatScreen(chatId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/story',
      builder: (context, state) {
        final imageUrl = state.uri.queryParameters['imageUrl']!;
        final name = state.uri.queryParameters['name']!;
        return StoryViewScreen(imageUrl: imageUrl, name: name);
      },
    ),
    // Keep old routes for compatibility if needed, but point to the new screen
    GoRoute(
      path: '/settings-profile',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/settings-interface',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
