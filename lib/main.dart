import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // 1

main() {
  final app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final router = GoRouter( // 2
    initialLocation: '/a', // 3
    routes: [
      GoRoute( // 4
        path: '/a', // 5
        builder: (context, state) => const ScreenA(), // 6
      ),
      GoRoute(
        path: '/b',
        builder: (context, state) => const ScreenB(),
      ),
      GoRoute(
        path: '/c',
        builder: (context, state) => const ScreenC(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) { // 7
    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.lime[50],
      title: const Text('スクリーンA'),
    );

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => context.push('/b'), 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[50]),
              child: const Text("【Bに進む】context.push('/b')"),
             )
          ],
        ),
      ),
    );
  }
}

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.yellow[50],
      title: const Text('スクリーンB'),
    );

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('【戻る】context.pop()'),
            ),
            ElevatedButton(
              onPressed: () => context.push('/c'),
              child: const Text("【Cに進む】context.push('/c')"),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenC extends StatelessWidget {
  const ScreenC({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.purple[50],
      title: const Text('スクリーンC'),
    );

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('【戻る】context.pop()'),
            ),
          ],
        ),
      ),
    );
  }
}