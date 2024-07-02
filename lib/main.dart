import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    initialLocation: '/main',
    routes: [
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) {
          return MainScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/main',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: FirstScreen(),
              );
            },
          ),
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: HomeScreen(),
              );
            },
            routes: [
              GoRoute(
                path: 'details',
                pageBuilder: (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: DetailsScreen(
                      title: 'Home Details',
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/business',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: BusinessScreen(),
              );
            },
            routes: [
              GoRoute(
                path: 'details',
                pageBuilder: (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: DetailsScreen(
                      title: 'Business Details',
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/school',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: SchoolScreen(),
              );
            },
            routes: [
              GoRoute(
                path: 'details',
                pageBuilder: (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: DetailsScreen(
                      title: 'School Details',
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

class MainScreen extends StatefulWidget {
  final Widget child;

  MainScreen({required this.child});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<String> _routePaths = [
    '/home',
    '/business',
    '/school',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.go(_routePaths[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Home Screen'),
          ElevatedButton(
            onPressed: () {
              context.go('/home/details');
            },
            child: Text('Go to Home Details'),
          ),
        ],
      ),
    );
  }
}
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('First Screen'),
          ElevatedButton(
            onPressed: () {
              context.go('/home');
            },
            child: Text('Go to Details'),
          ),
        ],
      ),
    );
  }
}

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Business Screen'),
          ElevatedButton(
            onPressed: () {
              context.go('/business/details');
            },
            child: Text('Go to Business Details'),
          ),
        ],
      ),
    );
  }
}

class SchoolScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('School Screen'),
          ElevatedButton(
            onPressed: () {
              context.go('/school/details');
            },
            child: Text('Go to School Details'),
          ),
        ],
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final String title;

  DetailsScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Details Screen: $title'),
      ),
    );
  }
}
