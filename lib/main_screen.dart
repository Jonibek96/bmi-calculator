import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'container_box.dart';
import 'data_container.dart';

const activeColor = Colors.teal;
const inActiveColor = Colors.white;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Color maleBoxColor = activeColor;
  Color femaleBoxColor = inActiveColor;
  int height = 180;
  int weight = 70;
  int age = 25;
  String result ='';
  String resultDetails ='';
  Color textColor = Colors.black;
  String resultText = '';
  double bmi = 0;

  void updateBoxColor(int gender) {
    if (gender == 1) {
      if (maleBoxColor == inActiveColor) {
        maleBoxColor = activeColor;
        femaleBoxColor = inActiveColor;
      } else {
        maleBoxColor = inActiveColor;
        femaleBoxColor = activeColor;
      }
    } else {
      if (femaleBoxColor == inActiveColor) {
        femaleBoxColor = activeColor;
        maleBoxColor = inActiveColor;
      } else {
        femaleBoxColor = inActiveColor;
        maleBoxColor = activeColor;
      }
    }
  }

  String calculateBmi(int weight, int height ){
    bmi = weight / pow(height / 100, 2);
    return bmi.toStringAsFixed(1);
  }

  String getInterpretation(double bmi){
    if(bmi >= 25){
      return  'У вас масса тела выше нормы. Старайтесь больше заниматься спортом. ';
    }else if(bmi > 18){
      return 'У вас нормальная масса тела. Отличная работа!';
    }else{
      return 'У вас есть любовник, чем нормальный вес тела. Вы можете съесть немного больше. ';
    }
  }

  void setResult() {
    if (bmi >= 25) {
      resultText = 'лишний вес';
      textColor = Colors.red;
    } else if (bmi > 18.5) {
      resultText = 'обычный';
      textColor = Colors.green;
    } else {
      resultText = 'недостаточный вес';
      textColor = Colors.blue;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        updateBoxColor(1);
                      });
                    },
                    child: ContainerBox(
                      boxColor: maleBoxColor,
                      childWidget: DataContainer(
                        iconData: Icons.male,
                        title: 'МУЖЧИНА',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        updateBoxColor(2);
                      });
                    },
                    child: ContainerBox(
                      boxColor: femaleBoxColor,
                      childWidget: DataContainer(
                        iconData: Icons.female,
                        title: 'ЖЕНЧИНА',
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: ContainerBox(
            boxColor: Color(0xFFffffff),
            childWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'РОСТ',
                  style: textStyle1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      height.toString(),
                      style: textStyle2,
                    ),
                    Text(
                      'cm',
                      style: textStyle1,
                    ),
                  ],
                ),
                Slider(
                  value: height.toDouble(),
                  min: 120.0,
                  max: 220.0,
                  //activeColor: activeColor,
                  //inactiveColor: inActiveColor,
                  onChanged: (double newValue){
                    setState(() {
                      height = newValue.round();
                    });
                },
                )
              ],
            ),
          )),
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: ContainerBox(
                  boxColor: Color(0xFFffffff),
                  childWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('ВЕС', style: textStyle1,),
                      Text(weight.toString(), style: textStyle2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FloatingActionButton(
                              backgroundColor: activeColor,
                              child: Icon(Icons.add, color: Colors.white,),
                            onPressed: (){
                                setState(() {
                                  weight++;
                                });
                            },
                          ),
                          SizedBox(width: 10.0,),
                          FloatingActionButton(
                            backgroundColor: activeColor,
                            child: Icon(Icons.remove, color: Colors.white,),
                            onPressed: (){
                              setState(() {
                                if(weight > 0){
                                  weight--;
                                }
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  )
                ),
              ),
              Expanded(
                child: ContainerBox(
                  boxColor: Color(0xFFffffff),
                  childWidget:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('ВОЗРАСТ', style: textStyle1,),
                      Text(age.toString(), style: textStyle2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FloatingActionButton(
                            backgroundColor: activeColor,
                            child: Icon(Icons.add, color: Colors.white,),
                            onPressed: (){
                              setState(() {
                                age++;
                              });
                            },
                          ),
                          SizedBox(width: 10.0,),
                          FloatingActionButton(
                            backgroundColor: activeColor,
                            child: Icon(Icons.remove, color: Colors.white,),
                            onPressed: (){
                              setState(() {
                                if(age > 0){
                                  age--;
                                }
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  )
                ),
              ),
            ],
          )),
          GestureDetector(
            onTap: () {
              setState(() {
                result = calculateBmi(weight, height);
                resultDetails = getInterpretation(bmi);
                setResult();
                showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return Dialog(
                      backgroundColor: inActiveColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),

                      ),
                      child: Container(
                        color: inActiveColor,
                        height: 200.0,
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(resultText, style: TextStyle(color: textColor, fontSize: 30.0)),
                            Text(result.toString(), style: textStyle2,),
                            /*if(bmi >= 25)...[Text('overweight', style: TextStyle(color: Colors.red, fontSize: 30.0),)
                            ]else if(bmi > 18.5)...[Text('normal', style: TextStyle(color: Colors.green, fontSize: 30.0),)
                            ]else...[Text('underweight', style: TextStyle(color: Colors.blue, fontSize: 30.0),)],*/
                            Text(resultDetails, style: textStyle1,),
                          ],
                        ),
                      ),
                    );
                  },
                );
              });
            },
             child: Container(
                child: Center(
                  child: Text('РАССЧИТАТЬ', style: textStyle3,),
                ),
                width: double.infinity,
                height: 80.0,
                color: activeColor,
                margin: EdgeInsets.only(top: 10.0))
          ),
        ],
      ),
    );
  }
}
