import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences _saveCount;
  List<dynamic> limitName = [
    'no limit',
    33,
    99,
    100,
  ];
  List<int> limit = [10000000000, 33, 99, 100];

  int counter = 0;
  int indexLimit = 0;

  @override
  void initState() {
    getCount();
    super.initState();
  }

  setCount() async {
    _saveCount.setInt('count', counter);
    await getCount();
  }

  getCount() async {
    _saveCount = await SharedPreferences.getInstance();
    counter = _saveCount.getInt('count') ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "القوة والقوة من الله",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 200, 0),
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  "$counter",
                  style: const TextStyle(
                      fontSize: 100,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              Container(
                height: 250,
                width: 250,
                child: FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    onPressed: () async {
                      counter >= limit[indexLimit] ? counter + 0 : counter++;
                      setCount();
                      setState(() {});
                      if (counter == limit[indexLimit]) {
                        return Vibration.vibrate();
                      }
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        FloatingActionButton.large(
                            onPressed: () async {
                              Vibration.vibrate();
                              counter = 0;
                              setCount();
                            },
                            backgroundColor: Colors.red,
                            child: const Text("Reset",
                                style: TextStyle(fontSize: 20))),
                        const Spacer(),
                        Column(
                          children: [
                            Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: PageView.builder(
                                  onPageChanged: (value) {
                                    indexLimit = value;
                                  },
                                  scrollDirection: Axis.vertical,
                                  itemCount: limitName.length,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(
                                          top: 15, bottom: 15),
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${limitName[index]}",
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    );
                                  })),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 30,
                          width: 20,
                          alignment: Alignment.bottomCenter,
                          child: const Icon(
                            Icons.swipe_down,
                            color: Color.fromARGB(255, 223, 214, 169),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
