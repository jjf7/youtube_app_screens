import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyInheritedWidget extends InheritedWidget {
  ValueNotifier<int> page = ValueNotifier<int>(0);
  PageController controller = PageController(viewportFraction: 0.74);

  MyInheritedWidget({
    super.key,
    required super.child,
  });

  static MyInheritedWidget of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<MyInheritedWidget>()!;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.close,
                    size: 40,
                  )),
            ),
          ],
        ),
        body: const Stack(
          children: [
            _ViewTitle(),
            _ViewPage(),
            _ViewDots(),
            _ViewButton(),
          ],
        ),
      ),
    );
  }
}

class _ViewDots extends StatelessWidget {
  const _ViewDots();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Positioned(
      top: size.height * 0.81,
      width: size.width,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Dot(index: 0),
          SizedBox(width: 5),
          _Dot(index: 1),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  const _Dot({required this.index});

  @override
  Widget build(BuildContext context) {
    final page = MyInheritedWidget.of(context).page;
    return ValueListenableBuilder(
        valueListenable: page,
        builder: (context, value, child) {
          return CircleAvatar(
            radius: 7,
            backgroundColor: value == index ? Colors.black87 : Colors.grey,
          );
        });
  }
}

class _ViewButton extends StatelessWidget {
  const _ViewButton();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * 0.84,
      left: size.width * 0.1,
      right: size.width * 0.1,
      height: 80,
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 8, 47, 243),
          ),
        ),
        onPressed: () {},
        child: const Text(
          '1 mes gratis',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}

class _ViewPage extends StatelessWidget {
  const _ViewPage();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * 0.20,
      bottom: size.height * 0.13,
      left: 0,
      right: 0,
      child: PageView(
        controller: MyInheritedWidget.of(context).controller,
        onPageChanged: (value) {
          MyInheritedWidget.of(context).page.value = value;
        },
        children: const [
          _MyCardWhite(),
          _MyCardBlack(),
        ],
      ),
    );
  }
}

class _MyCardBlack extends StatelessWidget {
  const _MyCardBlack();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: MyInheritedWidget.of(context).page,
      builder: (context, value, child) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: value == 1 ? 1 : 0.5,
          child: Card(
              color: Colors.black,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'YouTube Music Premium',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              )),
        );
      },
    );
  }
}

class _MyCardWhite extends StatelessWidget {
  const _MyCardWhite();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: MyInheritedWidget.of(context).page,
        builder: (context, value, child) {
          return AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: value == 0 ? 1 : 0.5,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 3.0,
                    ),
                  ),
                  color: Colors.white,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('YouTube Premium',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        ]),
                  )));
        });
  }
}

class _ViewTitle extends StatelessWidget {
  const _ViewTitle();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      left: size.width * 0.1,
      top: size.height * 0.05,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'YouTube sin',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'anuncios',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Incluye Premium y Music Premium',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
