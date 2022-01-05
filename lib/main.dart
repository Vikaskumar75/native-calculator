import 'package:easy_coding/big_head_softwares.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _firstNumber = TextEditingController();
  static const platform = MethodChannel('flutter.dev.calculator');

  final ValueNotifier<int?> _selectedIndex = ValueNotifier<int?>(null);
  final ValueNotifier<int> result = ValueNotifier<int>(0);

  Future<void> calculate(String operation) async {
    final int result = await platform.invokeMethod(
      operation,
      [
        this.result.value,
        int.parse(_firstNumber.text),
      ],
    );
    this.result.value = result;
  }

  @override
  void dispose() {
    _firstNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: scaffoldColor(context),
        title: const Text.rich(
          TextSpan(
            text: 'Native',
            children: [
              TextSpan(
                text: 'Calculator',
                style: TextStyle(color: Colors.pink),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ValueListenableBuilder(
                valueListenable: result,
                builder: (BuildContext context, int value, Widget? child) {
                  return SizedBox(
                    height: screenHeight(context) * 0.4,
                    child: FittedBox(
                      child: Text(
                        value.toString(),
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 200,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _firstNumber,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: 'Numbers are entered here',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink))),
              ),
              const SizedBox(height: 30),
              Wrap(
                runSpacing: 10,
                spacing: 12,
                children: List<Widget>.generate(
                  operations.length,
                  (index) {
                    return ValueListenableBuilder<int?>(
                      valueListenable: _selectedIndex,
                      builder:
                          (BuildContext context, int? value, Widget? child) {
                        return RoundContainer(
                          onTap: () {
                            if (_firstNumber.text.isNotEmpty) {
                              _selectedIndex.value = index;
                              calculate(operations[index].name);
                              _firstNumber.clear();
                            }
                          },
                          hPadding: 20,
                          vPadding: 20,
                          color: value == index
                              ? Colors.pink.shade800
                              : Colors.grey.shade800,
                          child: Icon(operations[index].icon),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Operations> operations = [
  Operations(
    icon: CupertinoIcons.add,
    name: 'add',
  ),
  Operations(
    icon: Icons.remove,
    name: 'subtract',
  ),
  Operations(
    icon: CupertinoIcons.multiply,
    name: 'multiply',
  ),
  Operations(
    icon: CupertinoIcons.divide,
    name: 'divide',
  ),
];

class Operations {
  final String name;
  final IconData icon;
  Operations({
    required this.name,
    required this.icon,
  });
}
