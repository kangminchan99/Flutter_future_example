import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = 'no data found';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Future test'), centerTitle: true),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    futureTest();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Future Test',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  result,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                ),
                FutureBuilder(
                    future: myFuture(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Text(
                          snapshot.data,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                        );
                      }
                      // 데이터를 수신중임.
                      return const CircularProgressIndicator();
                    })
              ],
            ),
          ),
        ));
  }

  // void futureTest() {
  //   Future.delayed(const Duration(seconds: 3)).then((value) {
  //     setState(() {
  //       result = 'The data is fetched';
  //     });
  //   });
  //   // Future를 만나게 되면, 관련 코드를 이벤트 큐에 넣고 그다음에 있는 코드를 비동기 방식으로 처리 되므로,
  //   // print 함수가 먼저 실행되고, them메소드가 실행된다.
  //   print('Here comes first');
  // }

  Future<void> futureTest() async {
    // Future가 await키워드를 만나면 실행되므로 print('Second');가 먼저 실행되고,
    // setState에 있는 result값이 'The data is fetched'가 할당되고 print(result), print('third')
    // 순으로 동작한다. 그다음  print('Here comes first'), print('last one')이 출력된다.
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      print('Second');

      setState(() {
        result = 'The data is fetched';
        print(result);
        print('third');
      });
    });

    print('Here comes first');
    print('last one');
  }

  //
  Future myFuture() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'another Future completed';
  }
}
