import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wisata_app/bloc/login/login_bloc.dart';
import 'package:wisata_app/bloc/register/register_bloc.dart';
import 'package:wisata_app/bloc/review/review_bloc.dart';
import 'package:wisata_app/bloc/search_coba/search_coba_bloc.dart';
import 'package:wisata_app/repo/objek_wisata_repository.dart';
import 'package:wisata_app/repo/register_repository.dart';
import 'package:wisata_app/repo/review_repository.dart';
import 'package:wisata_app/repo/search_coba_repository.dart';
import 'package:wisata_app/ui/halaman_utama.dart';
import 'package:wisata_app/repo/search_repository.dart';
import 'package:wisata_app/bloc/search/search_bloc.dart';
import 'package:wisata_app/ui/home_page.dart';
import 'package:wisata_app/ui/login_page.dart';
import 'package:wisata_app/ui/objek_wisata_pagi_page.dart';
import 'package:wisata_app/ui/profile_page.dart';
import 'package:wisata_app/ui/review_page.dart';
import 'package:wisata_app/ui/search_coba_page.dart';
import 'package:wisata_app/ui/searching_page.dart';
import 'bloc/objek_wisata/detail/objek_wisata_detail_bloc.dart';
import 'bloc/objek_wisata/pagination/objek_wisata_pagination_bloc.dart';
import 'cubit/setting_app_cubit.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('session');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SettingAppCubit>(
            create: (context) => SettingAppCubit(),
          ),
          BlocProvider<ObjekWisataPaginationBloc>(
            create: (context) => ObjekWisataPaginationBloc(
              objekWisataRepository: ObjekWisataRepository(),
            )..add(GetObjekWisataPaginationEvent()),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(),
          ),
          BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(
              registerRepository: RegisterRepository(),
            ),
          ),
          BlocProvider<ObjekWisataDetailBloc>(
            create: (context) => ObjekWisataDetailBloc(
              ObjekWisataRepository(),
            ),
          ),
          BlocProvider<SearchBloc>(
            create: (context) => SearchBloc(
              searchRepository: SearchRepository(),
            ),
          ),
          BlocProvider<SearchCobaBloc>(
            create: (context) => SearchCobaBloc(
              repository: SearchCobaRepository(),
            ),
          ),
          BlocProvider<ReviewBloc>(
            create: (context) => ReviewBloc(
              reviewRepository: ReviewRepository(),
            ),
          ),
        ],
        child: BlocBuilder<SettingAppCubit, SettingAppState>(
          builder: (context, state) {
            Widget _home;
            if (state is SettingAppAuthenticated) {
              _home = HalamanUtama();
            } else {
              _home = HalamanUtama();
            }
            return MaterialApp(
              title: 'Aplikasi Wisata',
              theme: ThemeData(
                primaryColor: Colors.white,
                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              home: _home,
              // initialRoute: '/',
              // routes: {
              //   '/': (context) => _home,
              //   '/search': (context) => SearchingPage(),
            );
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
