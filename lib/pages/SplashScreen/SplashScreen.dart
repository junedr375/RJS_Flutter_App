import 'package:artapp/pages/home/Home.dart';
import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation position_up_anim, position_down_anim;
  double postionVal = 1.0;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);

    position_up_anim = Tween<double>(begin: 0.6, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));

    position_down_anim = Tween<double>(begin: 0.0, end: 0.6).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn));

    animationController.repeat();
    animationController.addListener(() {
      setState(() {
        if (animationController.value >= 0 &&
            animationController.value <= 0.45) {
          postionVal = position_up_anim.value;
        } else if (animationController.value >= 0.55 &&
            animationController.value <= 1.0) {
          postionVal = position_down_anim.value;
        }
      });
    });

    Future.delayed(Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getMediaQuerySize(context);
    final theme = getThemeDataOfContext(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: theme.backgroundColor),
        height: screenSize.height,
        width: screenSize.width,
        child: Stack(
          children: [
            AnimatedBuilder(
                animation: animationController,
                builder: (BuildContext? context, Widget? child) {
                  return Positioned(
                    bottom: screenSize.height * postionVal,
                    child: Container(
                        height: screenSize.height * 0.7,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: screenSize.width,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        )),
                  );
                }),
            Positioned(
                bottom: 100,
                left: 0,
                child: Container(
                  width: screenSize.width,
                  child: Text(
                    'Articia',
                    style: theme.textTheme.headline1,
                    textAlign: TextAlign.center,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
