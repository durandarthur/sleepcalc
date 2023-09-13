import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay add({int hours = 0, int minutes = 0}) => TimeOfDay(
      hour: hour + hours + (minute + minutes) ~/ 60,
      minute: (minute + minutes) % 60);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleep Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueGrey, brightness: Brightness.dark),

        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sleep Calculator'),
    );
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
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(16),
            child: Card(
              color: Theme.of(context).colorScheme.surface,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Image(
                        image: AssetImage('images/moonIcon.png'),
                        color: Colors.white,
                        width: 100),
                    Text(
                        selectedTime != null
                            ? "You should wake up at :"
                            : "Pick a time to start.",
                        textScaleFactor: 2),
                    ConstrainedBox(
                      constraints: BoxConstraints.loose(Size(
                          MediaQuery.of(context).size.width * 0.8,
                          MediaQuery.of(context).size.height * 0.4)),
                      child: selectedTime != null
                          ? Expanded(
                              child: ListView(
                                children: [
                                  ListTile(
                                    leading: const Text(" - "),
                                    trailing: const Text(" for 4h30 of sleep"),
                                    title: Text(
                                        TimeOfDay(
                                                hour: selectedTime!.hour,
                                                minute: selectedTime!.minute)
                                            .add(hours: 4, minutes: 30)
                                            .format(context),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary)),
                                  ),
                                  ListTile(
                                    leading: const Text(" - "),
                                    trailing: const Text(" for 6h00 of sleep"),
                                    title: Text(
                                        TimeOfDay(
                                                hour: selectedTime!.hour,
                                                minute: selectedTime!.minute)
                                            .add(hours: 6, minutes: 0)
                                            .format(context),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary)),
                                  ),
                                  ListTile(
                                    leading: const Text(" - "),
                                    trailing: const Text(" for 7h30 of sleep"),
                                    title: Text(
                                        TimeOfDay(
                                                hour: selectedTime!.hour,
                                                minute: selectedTime!.minute)
                                            .add(hours: 7, minutes: 30)
                                            .format(context),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary)),
                                  ),
                                  ListTile(
                                    leading: const Text(" - "),
                                    trailing: const Text(" for 9h00 of sleep"),
                                    title: Text(
                                        TimeOfDay(
                                                hour: selectedTime!.hour,
                                                minute: selectedTime!.minute)
                                            .add(hours: 9, minutes: 0)
                                            .format(context),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary)),
                                  ),
                                ],
                              ),
                            )
                          : null,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 30)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Theme.of(context)
                                            .colorScheme
                                            .inversePrimary),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () async {
                              final TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: selectedTime ?? TimeOfDay.now());
                              setState(() {
                                selectedTime = time;
                              });
                            },
                            child: const Text('Pick time')),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                        FilledButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 30)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Theme.of(context)
                                            .colorScheme
                                            .inversePrimary),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () {},
                            child: const Text('Sleep now'))
                      ],
                    )
                  ],
                ),
              ]),
            )),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
