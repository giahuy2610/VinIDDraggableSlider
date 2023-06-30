import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller1;
  late AnimationController controller2;
  late AnimationController controller3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    controller.addListener(() async {
      setState(() {});
      if (controller.isCompleted) {
        await Future.delayed(Duration(seconds: 1));
        controller.reverse();
      } else if (controller.isDismissed) {
        await Future.delayed(Duration(seconds: 1));
        controller.forward();
      }
    });

    controller1 =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    controller1.addListener(() async {
      setState(() {});
      if (controller1.isCompleted) {
        await Future.delayed(Duration(seconds: 1));
        controller1.reverse();
      } else if (controller1.isDismissed) {
        await Future.delayed(Duration(seconds: 1));
        controller1.forward();
      }
    });

    controller2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    controller2.addListener(() async {
      setState(() {});
      if (controller2.isCompleted) {
        await Future.delayed(Duration(seconds: 1));
        controller2.reverse();
      } else if (controller2.isDismissed) {
        await Future.delayed(Duration(seconds: 1));
        controller2.forward();
      }
    });

    Future.delayed(Duration(seconds: 3)).then((value) => controller.forward());
    controller1.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SwitchCardsEvent());
  }
}

class SwitchCardsEvent extends StatefulWidget {
  const SwitchCardsEvent({Key? key}) : super(key: key);

  @override
  State<SwitchCardsEvent> createState() => _SwitchCardsEventState();
}

class _SwitchCardsEventState extends State<SwitchCardsEvent> {
  List<dynamic> listImage = [
    {
      'path': '65',
      'img':
          'https://image.hsv-tech.io/575x0/tfs/common/26d9c8c4-a082-4de7-98ff-38bca0492b9c.webp'
    },
    {
      'path': '65',
      'img':
          'https://image.hsv-tech.io/575x0/tfs/common/aa08a229-aa77-4686-a5de-88b1d91a9bd0.webp'
    },
    {
      'path': '65',
      'img':
          'https://image.hsv-tech.io/575x0/tfs/common/0dd3908c-4dc6-4f5c-abe2-b7e225be95e9.webp'
    },
    {
      'path': '65',
      'img':
          'https://image.hsv-tech.io/575x0/tfs/common/88b5d66c-faa9-4565-8172-6749e2b58f38.webp'
    }
  ];
  double distance = 0;
  GlobalKey stackGlobalKey = GlobalKey();
  GlobalKey draggingGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(50),
      alignment: Alignment.center,
      child: Stack(
        clipBehavior: Clip.none,
        key: stackGlobalKey,
        children: [
          for (var i in listImage)
            Positioned(
              top: -distance,
              left: -distance,
              child: Container(
                color: Colors.blueGrey,
                key: ObjectKey(i),
                margin: EdgeInsets.only(
                    left: 20 *
                        (listImage.length -
                            listImage.indexOf(i).toDouble() -
                            1),
                    top: 20 *
                        (listImage.length -
                            listImage.indexOf(i).toDouble() -
                            1)),
                child: GestureDetector(
                  onTap: () {},
                  child: Draggable(
                    onDragUpdate: (listener) {
                      final renderBox = stackGlobalKey.currentContext
                          ?.findRenderObject() as RenderBox;
                      Offset position = renderBox.localToGlobal(Offset.zero);
                      final renderBoxDrag = draggingGlobalKey.currentContext
                          ?.findRenderObject() as RenderBox;
                      Offset positionDrag =
                          renderBoxDrag.localToGlobal(Offset.zero);
                      print(position);
                      print(positionDrag);
                      if ((position.dy - positionDrag.dy).abs() > 100) {
                        print("spps");
                      } else {
                        if ((position.dy - positionDrag.dy).abs() / 5 >=
                            distance)
                          distance = (position.dy - positionDrag.dy).abs() / 5;
                      }
                    },
                    onDragEnd: (listener) {
                      if (MediaQuery.of(context).size.width / 5 >
                          listener.offset.dx) {
                        setState(() {
                          distance = 0;
                          listImage.insert(0, i);
                          listImage.removeLast();
                        });
                      }
                    },
                    childWhenDragging: Container(),
                    feedback: Container(
                      key: draggingGlobalKey,
                      child: Image.network(
                        i['img']!,
                        fit: BoxFit.cover,
                        width: 220,
                        height: 220,
                      ),
                    ),
                    child: Image.network(
                      i['img']!,
                      fit: BoxFit.cover,
                      width: 220,
                      height: 220,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
