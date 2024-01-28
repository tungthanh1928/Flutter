import 'dart:async';
import 'package:flutter/material.dart';

void main() {
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: HomeScreen(),
        );
    }
}

class HomeScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Chọn chương trình'),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        ElevatedButton(
                            onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => FutureScreen()),
                                );
                            },
                            child: Text('1. Sử dụng Future'),
                        ),
                        ElevatedButton(
                            onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => FutureBuilderScreen()),
                                );
                            },
                            child: Text('2. Sử dụng FutureBuilder'),
                        ),
                        ElevatedButton(
                            onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => StreamScreen()),
                                );
                            },
                            child: Text('3. Sử dụng Stream'),
                        ),
                        ElevatedButton(
                            onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => StreamBuilderScreen()),
                                );
                            },
                            child: Text('4. Sử dụng StreamBuilder'),
                        ),
                        ElevatedButton(
                            onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TotalSumScreen()),
                                );
                            },
                            child: Text('5. Tính tổng sử dụng 2 màn hình'),
                        ),
                    ],
                ),
            ),
        );
    }
}

class FutureScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Sử dụng Future'),
            ),
            body: Center(
                child: FutureWidget(),
            ),
        );
    }
}

class FutureWidget extends StatelessWidget {
    Future<double> _calculateSum(double num1, double num2) async {
        await Future.delayed(Duration(seconds: 2));
        return num1 + num2;
    }

    @override
    Widget build(BuildContext context) {
        TextEditingController controller1 = TextEditingController();
        TextEditingController controller2 = TextEditingController();

        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                TextField(
                    controller: controller1,
                    decoration: InputDecoration(labelText: 'Nhập số thứ nhất'),
                    keyboardType: TextInputType.number,
                ),
                TextField(
                    controller: controller2,
                    decoration: InputDecoration(labelText: 'Nhập số thứ hai'),
                    keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                        double num1 = double.tryParse(controller1.text) ?? 0;
                        double num2 = double.tryParse(controller2.text) ?? 0;

                        showDialog(
                            context: context,
                            builder: (context) {
                                return FutureBuilder<double>(
                                    future: _calculateSum(num1, num2),
                                    builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                            return Text('Lỗi: ${snapshot.error}');
                                        } else {
                                            return AlertDialog(
                                                title: Text('Tổng'),
                                                content: Text('Tổng = ${snapshot.data}'),
                                                actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                            Navigator.pop(context);
                                                        },
                                                        child: Text('Đóng'),
                                                    ),
                                                ],
                                            );
                                        }
                                    },
                                );
                            },
                        );
                    },
                    child: Text('Tính Tổng'),
                ),
            ],
        );
    }
}

class FutureBuilderScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Sử dụng FutureBuilder'),
            ),
            body: Center(
                child: ElevatedButton(
                    onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                                return FutureBuilder<double>(
                                    future: Future.delayed(Duration(seconds: 2), () {
                                        double num1 = 10.5;
                                        double num2 = 5.5;
                                        return num1 + num2;
                                    }),
                                    builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                            return Text('Lỗi: ${snapshot.error}');
                                        } else {
                                            return AlertDialog(
                                                title: Text('Tổng'),
                                                content: Text('Tổng = ${snapshot.data}'),
                                                actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                            Navigator.pop(context);
                                                        },
                                                        child: Text('Đóng'),
                                                    ),
                                                ],
                                            );
                                        }
                                    },
                                );
                            },
                        );
                    },
                    child: Text('Hiển thị Tổng'),
                ),
            ),
        );
    }
}

class StreamScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Sử dụng Stream'),
            ),
            body: Center(
                child: StreamWidget(),
            ),
        );
    }
}

class StreamWidget extends StatefulWidget {
    @override
    _StreamWidgetState createState() => _StreamWidgetState();
}

class _StreamWidgetState extends State<StreamWidget> {
    late StreamController<double> _streamController;
    late Stream<double> _stream;

    @override
    void initState() {
        super.initState();
        _streamController = StreamController<double>();
        _stream = _streamController.stream;

        _generateStreamValues();
    }

    void _generateStreamValues() async {
        double num1 = 10.5;
        double num2 = 5.5;

        for (int i = 0; i < 5; i++) {
            await Future.delayed(Duration(seconds: 1));
            _streamController.add(num1 + num2);
        }
    }

    @override
    Widget build(BuildContext context) {
        return StreamBuilder<double>(
            stream: _stream,
            builder: (context, snapshot) {
                if (snapshot.hasError) {
                    return Text('Lỗi: ${snapshot.error}');
                } else if (snapshot.hasData) {
                    return Text('Tổng = ${snapshot.data}');
                } else {
                    return CircularProgressIndicator();
                }
            },
        );
    }

    @override
    void dispose() {
        _streamController.close();
        super.dispose();
    }
}

class StreamBuilderScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Sử dụng StreamBuilder'),
            ),
            body: Center(
                child: ElevatedButton(
                    onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                                return StreamBuilder<double>(
                                    stream: Stream<double>.periodic(
                                        Duration(seconds: 1),
                                            (value) => 10.5 + 5.5,
                                    ).take(5),
                                    builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                            return Text('Lỗi: ${snapshot.error}');
                                        } else if (snapshot.hasData) {
                                            return AlertDialog(
                                                title: Text('Tổng'),
                                                content: Text('Tổng = ${snapshot.data}'),
                                                actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                            Navigator.pop(context);
                                                        },
                                                        child: Text('Đóng'),
                                                    ),
                                                ],
                                            );
                                        } else {
                                            return CircularProgressIndicator();
                                        }
                                    },
                                );
                            },
                        );
                    },
                    child: Text('Hiển thị Tổng'),
                ),
            ),
        );
    }
}

class TotalSumScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Tính tổng sử dụng 2 màn hình'),
            ),
            body: Center(
                child: ElevatedButton(
                    onPressed: () async {
                        double? num1 = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondPage(),
                            ),
                        );

                        if (num1 != null) {
                            double? num2 = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondPage(),
                                ),
                            );

                            if (num2 != null) {
                                double sum = num1 + num2;

                                showDialog(
                                    context: context,
                                    builder: (context) {
                                        return AlertDialog(
                                            title: Text('Tổng'),
                                            content: Text('Tổng = $sum'),
                                            actions: [
                                                TextButton(
                                                    onPressed: () {
                                                        Navigator.pop(context);
                                                    },
                                                    child: Text('Đóng'),
                                                ),
                                            ],
                                        );
                                    },
                                );
                            }
                        }
                    },
                    child: Text('Tính Tổng'),
                ),
            ),
        );
    }
}

class SecondPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        TextEditingController controller = TextEditingController();

        return Scaffold(
            appBar: AppBar(
                title: Text('Second Page'),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text('Nhập số:'),
                        SizedBox(height: 10),
                        TextField(
                            controller: controller,
                            decoration: InputDecoration(labelText: 'Nhập số'),
                            keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () {
                                double? num = double.tryParse(controller.text);
                                Navigator.pop(context, num);
                            },
                            child: Text('Xác nhận'),
                        ),
                    ],
                ),
            ),
        );
    }
}
