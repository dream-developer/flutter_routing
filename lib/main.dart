import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // 1

main() {
  final app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final router = GoRouter( // 2
    debugLogDiagnostics: true, // 遷移のデバッグ出力をする
    initialLocation: '/a', // 3
    routes: [
      GoRoute( // 4
        path: '/a', // 5
        builder: (context, state) => const ScreenA(), // 6
      ),
      GoRoute(
        path: '/b/:id/:code', // idとcodeの２つのパラメータを受け取る例
        builder: (context, state) {
          final id = state.pathParameters['id']; // パラメータを受け取ります
          final code = state.pathParameters['code'];
              return ScreenB(
                id: int.parse(id!), // int型にして渡す
                code: code!,
              );
        },
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
              //onPressed: () => context.push('/b'),
              onPressed: () => context.push('/b/100/abcd'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[50]),
              child: const Text("【Bに進む】context.push('/b')"),
             ),
            ElevatedButton(
              onPressed: () => context.go('/c'), 
              child: const Text("Cを指定し直接行く】context.go('/c')"),
             ),
          ],
        ),
      ),
    );
  }
}

class ScreenB extends StatelessWidget {
  const ScreenB({ 
    super.key,
    required this.id,
    required this.code,
  });

  final int id;
  final String code;

  @override
  Widget build(BuildContext context) {
    
    String idStr = "$id";

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

            Text("id:$idStr, code:$code"),
            
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