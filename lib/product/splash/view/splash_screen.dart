import 'package:auto_route/auto_route.dart';
import 'package:tekvando/core/cache/shared_pref.dart';
import 'package:tekvando/core/extension/screen_size.dart';
import 'package:tekvando/core/log/log.dart';
import 'package:tekvando/core/navigation/app_router.dart';
import 'package:tekvando/core/utilty/color_items.dart';
import 'package:flutter/material.dart';
import 'package:tekvando/core/utilty/duration_items.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(DurationItem.medium.str()).then((_) async {
      final userToken = await SharedPref().getUserToken();
      final bool auth = await SharedPref().getAuth();
      Log.info(userToken);
      Log.info(auth);
      if (!auth) {
        // ignore: use_build_context_synchronously
        context.router.replaceNamed(RouterItem.login.str());
      } else {
        if (userToken != null) {
          context.router.replaceNamed(RouterItem.bottomNavigation.str());
        } else {
          await SharedPref().setAuth(false).then((_) {
            // ignore: use_build_context_synchronously
            context.router.replaceNamed(RouterItem.login.str());
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorItem.labelColor.str(),
      body: Stack(
        children: [
          const Center(
            child: Text(
              "tekvando",
              style: TextStyle(
                fontFamily: 'Akasi',
                fontSize: 75,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            child: SizedBox(
              width: context.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "powerd by mehmet",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
