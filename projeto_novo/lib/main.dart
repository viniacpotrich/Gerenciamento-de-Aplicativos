import 'package:acta/acta.dart';
import 'package:flutter/material.dart';
import 'package:projeto_novo/helper.dart';
import 'package:projeto_novo/reseter.dart';

void main() {
  var ipMachine = '192.168.3.4';
  ActaJournal.initialize(
    appRunner: () => oldMain(),
    reporters: [
      ConsoleReporter(),
      MongoReporter(
        connectionString:
            'mongodb://root:root@$ipMachine:27017/Logs?authSource=admin',
        dbName: 'mongodb',
        collection: 'Logs',
      ),
      ElasticsearchReporter(
        connectionString: 'http://$ipMachine:9200',
        indexPattern: 'logsappnovo',
      ),
    ],
    onCaptured: showPopUp,
  );
}

void oldMain() => runApp(Reseter());

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      scaffoldMessengerKey: scaffoldMessengerKey,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await ActaJournal.report(event: BaseEvent(message: "Evento base no mongo"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () {
                throw (Exception('ERRO'));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error),
                  SizedBox(width: 5),
                  Text("Gerar Erro!"),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
