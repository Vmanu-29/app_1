import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

/// App con go_router, GridView, TabBar, ExpansionTile
/// y prints del ciclo de vida de StatefulWidget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definición de rutas con go_router
    final GoRouter router = GoRouter(
      initialLocation: '/',
      routes: <GoRoute>[
        GoRoute(
          name: 'PRINCIPAL',
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          name: 'DETALLES',
          path: '/details/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            final from = state.uri.queryParameters['from'] ?? 'desconocido';
            return DetailsScreen(itemId: id, from: from);
          },
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Taller - Paso de parámetros',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int contador = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print('HomeScreen: initState()');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('HomeScreen: didChangeDependencies()');
  }

  @override
  Widget build(BuildContext context) {
    print('HomeScreen: build()');
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pantalla principal'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Cuadrícula'),
              Tab(text: 'Extras'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: GridView de elementos
            GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                final id = (index + 1).toString();
                return GestureDetector(
                  onTap: () {
                    context.push('/details/$id?from=push');
                  },
                  child: Card(child: Center(child: Text('Elemento #$id'))),
                );
              },
            ),
            // Tab 2: Extras incluyendo ExpansionTile y botones
            ListView(
              padding: const EdgeInsets.all(12),
              children: [
                ExpansionTile(
                  title: const Text('Widget extra: ExpansionTile'),
                  children: const [
                    ListTile(
                      title: Text('Aquí puedes mostrar más información.'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    context.go('/details/99?from=go');
                  },
                  child: const Text('Ir con go() (Elemento 99)'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    context.push('/details/100?from=push');
                  },
                  child: const Text('Ir con push() (Elemento 100)'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    context.replace('/details/101?from=replace');
                  },
                  child: const Text('Ir con replace() (Elemento 101)'),
                ),
                const SizedBox(height: 20),
                Text('Contador: $contador'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      contador++;
                      print('HomeScreen: setState() → contador=$contador');
                    });
                  },
                  child: const Text('Incrementar contador'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print('HomeScreen: dispose()');
    super.dispose();
  }
}

class DetailsScreen extends StatefulWidget {
  final String itemId;
  final String from;

  const DetailsScreen({super.key, required this.itemId, required this.from});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    print('DetailsScreen: initState() para el elemento ${widget.itemId}');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(
      'DetailsScreen: didChangeDependencies() para el elemento ${widget.itemId}',
    );
  }

  @override
  Widget build(BuildContext context) {
    print('DetailsScreen: build() para el elemento ${widget.itemId}');
    return Scaffold(
      appBar: AppBar(title: Text('Detalle - Elemento ${widget.itemId}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID del elemento: ${widget.itemId}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text('Origen (parámetro query): ${widget.from}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Volver con Navigator.pop()'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final siguiente = (int.parse(widget.itemId) + 1).toString();
                context.push('/details/$siguiente?from=push_desde_detalles');
              },
              child: const Text('Ir al siguiente detalle con push()'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text('Volver al inicio con go()'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('DetailsScreen: dispose() para el elemento ${widget.itemId}');
    super.dispose();
  }
}
