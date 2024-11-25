import 'package:auto_route/auto_route.dart';
import 'package:tekvando/core/cache/shared_pref.dart';
import 'package:tekvando/core/extension/screen_size.dart';
import 'package:tekvando/core/log/log.dart';
import 'package:tekvando/core/navigation/app_router.dart';
import 'package:tekvando/core/utilty/images_items.dart';
import 'package:tekvando/product/auth/login/model/login_model.dart';
import 'package:tekvando/product/auth/login/service/login_service.dart';
import 'package:tekvando/product/auth/login/view_model/login_view_model.dart';
import 'package:tekvando/product/general/model/base_response.dart';
import 'package:tekvando/product/general/widget/custom_button_widget.dart';
import 'package:tekvando/product/general/widget/social_login_widget_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _mail =
      TextEditingController(text: "user@gmail.com");
  final TextEditingController _password =
      TextEditingController(text: "password");

  @override
  Widget build(BuildContext context) {
    var state = context.watch<LoginViewModel>();
    return WillPopScope(
      onWillPop: () async {
        Log.info("kullanıcı uygulmadan çıkmak istedi");
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(
                  ImageItem.logo.str(),
                  width: context.width / 2.5,
                ),
                Text(
                  "Giriş",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: const Color(0xFF4C5980),
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Kafede buluş, eğlenceli oyunlarla sosyalleş, yeni insanlarla tanış ve anın tadını çıkar!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: const Color(0xFF4C5980),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email Adresi",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: const Color(0xFF4C5980),
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      const SizedBox(height: 3),
                      TextFormField(
                        controller: _mail,
                        decoration: const InputDecoration(
                          hintText: "Mail adresinizi giriniz",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Boş bırakılamaz";
                          }
                          if (value.isEmpty) {
                            return 'E-posta adresi boş olamaz';
                          }
                          if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return 'Geçerli bir e-posta adresi girin';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Parola",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: const Color(0xFF4C5980),
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      const SizedBox(height: 3),
                      TextFormField(
                        obscureText: state.passwordVisibility,
                        obscuringCharacter: "*",
                        controller: _password,
                        decoration: InputDecoration(
                          hintText: "Parolanızı giriniz",
                          suffixIcon: IconButton(
                            onPressed: () {
                              context
                                  .read<LoginViewModel>()
                                  .changePasswordVisibility();
                            },
                            icon: Icon(state.passwordVisibility
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Boş bırakılamaz";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // context.router
                        //     .replaceNamed(RouterItem.forgotPassword.str());
                      },
                      child: Text(
                        "Şifremi Unuttum ?",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: const Color(0xFF9C9EB9),
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                CustomButton(
                  text: 'Giriş',
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      //TODO login işlemi yap
                      context.router
                          .replaceNamed(RouterItem.bottomNavigation.str());
                      // String? id = await SharedPref().getOnesignalId();
                      // if (id == null) {
                      //   id = OneSignal.User.pushSubscription.id;
                      //   await SharedPref().setOnesignalId(id ?? "");
                      // }
                      // await LoginService()
                      //     .customerLogin(_mail.text, _password.text, id)
                      //     .then((valueResponse) async {
                      //   Log.info("başarılı : ${valueResponse.success}");
                      //   if (valueResponse.success &&
                      //       valueResponse.data?.token != null) {
                      //     Log.info(valueResponse);
                      //     await SharedPref().setAuth(true).then(
                      //       (_) async {
                      //         await SharedPref()
                      //             .setUserId(valueResponse.data!.user.id)
                      //             .then((_) async {
                      //           if (valueResponse.data?.roles[0] == "user") {
                      //             await SharedPref()
                      //                 .setUserToken(valueResponse.data!.token)
                      //                 .then((_) {
                      //               // ignore: use_build_context_synchronously
                      //               context.router.replaceNamed(
                      //                   RouterItem.bottomNavigation.str());
                      //             });
                      //           } else {
                      //             EasyLoading.showError(
                      //                 "Hata oluştu. Yetkili birime iletiniz !");
                      //           }
                      //         });
                      //       },
                      //     );
                      //   } else {
                      //     // ignore: use_build_context_synchronously
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //           content: Text('Giriş bilgileri hatalı !')),
                      //     );
                      //   }
                      //   return valueResponse;
                      // });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Lütfen geçerli bilgiler ile doldurunuz !')),
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "ya da",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: const Color(0xFF4C5980),
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialLoginCardWidget(
                      image: ImageItem.apple,
                      onTap: () {},
                    ),
                    const SizedBox(width: 20),
                    SocialLoginCardWidget(
                      image: ImageItem.google,
                      onTap: () {},
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hesabınız yok mu ?",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: const Color(0xFF9C9EB9),
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.router.replaceNamed(RouterItem.register.str());
                      },
                      child: Text(
                        "Kayıt Ol",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: const Color(0xFF4C5980),
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
