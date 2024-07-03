import 'package:flutter/material.dart';
import 'dart:async';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  late Timer timer; //late를 사용함으로써 지금 당장 초기화 하지 않아도 됨
  bool isRunning = false; //false면 멈춤상태, true면 작동상태
  int counter = 0; // 포모도로 완료 횟수

  void onTick(Timer timer){ //시간이 1500에서 1뺌
  if(totalSeconds == 0){  //시간이 0이 되면 
    setState(() {
          isRunning = false;   //작동을 멈추고, 시간 초기화, 포모도로 완료횟수 + 1
          totalSeconds = twentyFiveMinutes;
          counter += 1;
        });
      timer.cancel(); //타이머 작동 종료
    }
  else{  //그게 아니면 1초에 totalSeconds에서 1초씩 빼기
    setState(() {
          totalSeconds -= 1;
        });
    }
  }

  void onStartPressed(){  //버튼 눌렀을때 작동 함수
    timer = Timer.periodic(
      Duration(seconds: 1),
      onTick,     //매 1초 마다 onTick함수가 실행됨
      );

    setState(() { //버튼 클릭시 작동중인 상태임을 알림
          isRunning = true;
        });
    }

  void onPausePressed(){ //버튼 눌렀을떄 정지함수
    timer.cancel();

    setState(() {  //버튼 눌렀을때 정지상태임을 알림
          isRunning = false;
        });
  }

  String format(int seconds){
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2,7);
    //duration의 값을 문자열로 바꾼뒤 '.'문자를 기준으로 나눠줌.. 원본 : 0:25:00.000000
    //그러면 [0:25:00,000000] 이렇게 나눠지고 이중에서 첫번째거를 이용하는데
    //이 첫번째 요소인 0:25:00에서도 2~7 idx까지만 이용
    
  }

  void onRestart(){
    setState(() {
          totalSeconds = twentyFiveMinutes;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,  //컨테이너 상에서 조정
              child: Text(format(totalSeconds),
              style:  TextStyle(
                color: Theme.of(context).cardColor,
                fontSize: 89,
                fontWeight: FontWeight.w600,

              ),),
          )
           
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    icon: Icon(isRunning? Icons.pause_circle_outlined :Icons.play_circle_outlined),
                    onPressed: isRunning? onPausePressed:onStartPressed,
                  ),
                  TextButton(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(50),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Restart',
                          style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.headline1!.color,
                          
                          ),
                        ),
                      ),
                    ),
                    
                    onPressed: onRestart,
                  ),
                ],
              ),
              

            ),
          ),

          Flexible(
            flex:1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                      
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Pomodoros',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.headline1!.color,
                          fontWeight: FontWeight.w600,
                        ),),
                        Text('$counter',
                        style: TextStyle(
                          fontSize: 58,
                          color: Theme.of(context).textTheme.headline1!.color,
                          fontWeight: FontWeight.w600,
                        ),),

                      ],
                    ),
          
          ),
                ),
              ],
            )
           
          ),

        ],
      )
    );
  }
}
