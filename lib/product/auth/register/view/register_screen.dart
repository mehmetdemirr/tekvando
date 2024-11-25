import 'package:auto_route/auto_route.dart';
import 'package:tekvando/core/cache/shared_pref.dart';
import 'package:tekvando/core/extension/screen_size.dart';
import 'package:tekvando/core/function/print_function.dart';
import 'package:tekvando/core/log/log.dart';
import 'package:tekvando/core/navigation/app_router.dart';
import 'package:tekvando/core/utilty/images_items.dart';
import 'package:tekvando/product/auth/register/viewmodel/register_view_model.dart';
import 'package:tekvando/product/general/widget/custom_button_widget.dart';
import 'package:tekvando/product/general/widget/social_login_widget_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordAgain = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var state = context.watch<RegisterViewModel>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Kayıt Ol",
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
                        "Ad",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: const Color(0xFF4C5980),
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      const SizedBox(height: 3),
                      TextFormField(
                        controller: _userName,
                        decoration: const InputDecoration(
                          hintText: "Adınızı giriniz",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Boş bırakılamaz";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
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
                          hintText: "Email adresinizi giriniz",
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
                                  .read<RegisterViewModel>()
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
                          if (value.length < 6) {
                            return "Minimum 6 karekter olmalı !";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Parola Tekrarı",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: const Color(0xFF4C5980),
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      const SizedBox(height: 3),
                      TextFormField(
                        obscureText: state.passwordAgainVisibility,
                        obscuringCharacter: "*",
                        controller: _passwordAgain,
                        decoration: InputDecoration(
                          hintText: "Parola tekrarınızı giriniz",
                          suffixIcon: IconButton(
                            onPressed: () {
                              context
                                  .read<RegisterViewModel>()
                                  .changePasswordAgainVisibility();
                            },
                            icon: Icon(state.passwordAgainVisibility
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Boş bırakılamaz";
                          }
                          if (value.length < 6) {
                            return "Minimum 6 karekter olmalı !";
                          }
                          if (value != _password.text) {
                            return "Parolalar eşleşmiyor !";
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
                    SizedBox(
                      width: context.width - 32,
                      child: CheckboxListTile.adaptive(
                        value: state.checkBox,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Row(
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text: "Devam etmek için Fıtı Fıtı'nın ",
                                  style: const TextStyle(
                                    color: Color(0xFF4C5980),
                                  ), // Genel metin stili
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Hüküm ve Koşullarını',
                                      style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xFF4C5980),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          printf('Hüküm ve Koşulları tıklandı');
                                        },
                                    ),
                                    const TextSpan(
                                      text: ' ve ', // Bu kısım normal
                                      style: TextStyle(
                                        color: Color(0xFF4C5980),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Gizlilik Politikasını',
                                      style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xFF4C5980),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Log.info(
                                              "Gizlilik politikası tıklandı");
                                        },
                                    ),
                                    const TextSpan(
                                      text: ' kabul etmiş olursunuz.',
                                      style: TextStyle(
                                        color: Color(0xFF4C5980),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        onChanged: (value) {
                          context.read<RegisterViewModel>().changeCheckBox();
                        },
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     context.router
                    //         .replaceNamed(RouterItem.forgotPassword.str());
                    //   },
                    //   child: Text(
                    //     "Şifremi Unuttum ?",
                    //     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    //           color: const Color(0xFF9C9EB9),
                    //         ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 15),
                CustomButton(
                  text: 'Kayıt Ol',
                  onTap: () async {
                    if (state.checkBox) {
                      if (_formKey.currentState!.validate()) {
                        String? id = await SharedPref().getOnesignalId();
                        if (id == null) {
                          id = OneSignal.User.pushSubscription.id;
                          if (id != null) {
                            await SharedPref().setOnesignalId(id);
                          } else {
                            EasyLoading.showInfo(
                                "Bildirim için yapılandırma olmadı!\nTekrardan giriş yapmanız önerilir!");
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Lütfen geçerli bilgiler ile doldurunuz !')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sözleşmeyi onaylayın !')),
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
                      "Hesabınız var mı ?",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: const Color(0xFF9C9EB9),
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.router.replaceNamed(RouterItem.login.str());
                      },
                      child: Text(
                        "Giriş yap",
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
