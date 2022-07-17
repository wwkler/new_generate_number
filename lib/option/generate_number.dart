import 'package:flutter/material.dart';
import 'package:new_generate_number/screen/home_screen.dart';

class OptionScreen extends StatefulWidget {
  OptionScreen({Key? key}) : super(key: key);

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  // OptionScreen page에 나타날 숫자 (일단 기본값은 1000으로 해놨다. 상황에 따라 달라질 것)
  int number = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: myBoxDecroation(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TopView(),
              MiddleView(onSliderChanged: onSliderChanged, number: number),
              BottomView(onButtonPressed: onButtonPressed)
            ],
          ),
        ),
      ),
    );
  }

  // OptionScreen Page에서 Slider를 움직일 떄 Event
  void onSliderChanged(double value) {
    // 바로 build 함수를 실행하게 한다.
    setState(() {
      number = value.toInt();
    });
  }

  // OptionScreen Page에서 Button을 click했을 떄 Event 처리
  void onButtonPressed() {
    // 데이터를 가지고 이전 페이지로 Intent 화면 전환
    Navigator.of(context).pop(number); // 해당 페이지는 아예 사라지는거임 dispose가 불린거임!!!!
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
  const TopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Slider를 이용한 최대 숫자 정하기',
        style: TextStyle(
            color: Color(0xffc77b93),
            fontSize: 20.0,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

// 랜덤 숫자가 나타남, 슬라이더가 있는 View
class MiddleView extends StatelessWidget {
  final ValueChanged<double> onSliderChanged;
  int number;

  MiddleView({required this.onSliderChanged, required this.number, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            imageView(),
            SizedBox(
              height: 30,
            ),
            slider()
          ],
        ));
  }

  // imageView를 나타내는 함수
  Row imageView() {
    return Row(
      children: number
          .toString()
          .split('')
          .map((e) => Image.asset(
                'asset/img/${e}.png',
                width: 75.0,
                height: 75.0,
              ))
          .toList(),
    );
  }

  // Slider를 나타내는 함수
  Slider slider() {
    return Slider(
        value: number.toDouble(),
        min: 100,
        max: 10000,
        onChanged: onSliderChanged);
  }
}

// 랜덤 최대 숫자를 저장하는 BottomView
class BottomView extends StatelessWidget {
  final VoidCallback onButtonPressed;
  const BottomView({required this.onButtonPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, children: [button()]),
    ));
  }

  ElevatedButton button() {
    return ElevatedButton(
        onPressed: onButtonPressed,
        style: ElevatedButton.styleFrom(
            primary: Colors.red[300],
            onPrimary: Colors.white,
            textStyle: TextStyle(fontWeight: FontWeight.w700)),
        child: Text(
          '최대 숫자 저장하기',
        ));
  }
}
