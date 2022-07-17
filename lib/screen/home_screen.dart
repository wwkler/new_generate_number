import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:new_generate_number/option/generate_number.dart';

// 메인 화면 페이지
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 최대 숫자에 기반하여 랜덤으로 돌려진 element를 저장하는 리스트
  //(처음에는 123, 456, 789가 나오지만, 랜덤 숫자를 돌리면 다양한 숫자가 나온다.)
  List<int> numberList = [123, 456, 789];

  // 최대 숫자(처음에는 기본값 1000 세팅, 다음에는 다른 숫자가 나온다.)
  int receivedNumber = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: myBoxDecroation(),
          child: Column(
            children: [
              // Top View
              TopView(
                onOptionPressed: onOptionPressed,
              ),

              // 최대 숫자 표시하는 부분
              Top_MiddleView(recevidedNumber: receivedNumber),

              // Middle View (랜덤 숫자 나오는 부분 )
              MiddleView(numberList: numberList),

              // Bottom View (하단 버튼 나오는 부분)
              BottomView(onButtonPressed: onButtonPressed)
            ],
          ),
        ),
      ),
    );
  }

  // MainPage에서 하단 Button을 눌렀을떄 Event
  void onButtonPressed() {
    //일단 3개 element를 가진 Set를 형성한다. (Set은 순서가 없고, 중복을 허용하지 않기 떄문에 지금 사용하기 적합하다.)
    Set<int> setnumberList = {};

    final randomNumber = Random();

    // 무조건 element가 3개가 들어가도록 한다.
    while (setnumberList.length != 3) {
      setnumberList.add(randomNumber.nextInt(receivedNumber));
    }

    setState(() {
      // 원래 존재하던 List에 element를 넣는다.
      numberList = setnumberList.toList();
    });
  }

  // MainPage에서 상단 톱니바퀴를 눌렀을 떄 Event
  // async가 필요하나, 결국 코드 흐름이 synchronous가 필요한 경우
  void onOptionPressed() async {
    // Intent 화면 전환
    int? result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return OptionScreen();
    })) as int;

    // 사용자가 정상적으로 button을 눌렀을 때
    if (result != null) {
      setState(() {
        receivedNumber = result;
      });
    }
    // 사용자가 비정상적으로 action을 취할 떄
    else {
      setState(() {});
    }
  }

  // Custom myBoxDecoration
  BoxDecoration myBoxDecroation() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFdfe8e2), Color(0xFF7df0a9)]));
  }
}

// TopView
class TopView extends StatelessWidget {
  final VoidCallback onOptionPressed;
  const TopView({required this.onOptionPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양 끝으로
        children: [
          Text(
            'Random Number App',
            style: TextStyle(
                color: Color(0xffc77b93),
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
          ),
          IconButton(
              onPressed: onOptionPressed,
              icon: Icon(Icons.settings),
              color: Colors.red)
        ],
      ),
    );
  }
}

// 최대 숫자를 보여주는 Top_MiddleView
class Top_MiddleView extends StatelessWidget {
  final recevidedNumber;
  const Top_MiddleView({required this.recevidedNumber, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('최대 숫자 : ${recevidedNumber}'),
    );
  }
}

// MiddleView (랜덤 숫자가 나오는 부분 )
class MiddleView extends StatelessWidget {
  final List<int> numberList;

  const MiddleView({required this.numberList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: numberList
                  .asMap()
                  .entries
                  .map((e) => Padding(
                        padding: (e.key == 2)
                            ? EdgeInsets.only(bottom: 0.0)
                            : EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          children: e.value
                              .toString()
                              .split('')
                              .map((e) => Image.asset(
                                    'asset/img/${e}.png',
                                    width: 75.0,
                                    height: 75.0,
                                  ))
                              .toList(),
                        ),
                      ))
                  .toList())),
    );
  }
}

// BottomView
class BottomView extends StatelessWidget {
  final VoidCallback onButtonPressed;
  const BottomView({required this.onButtonPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(
                primary: Colors.red[300],
                onPrimary: Colors.white,
                textStyle: TextStyle(fontWeight: FontWeight.w700)),
            child: Text(
              '랜덤 숫자 돌리기',
            )),
      ]),
    );
  }
}
