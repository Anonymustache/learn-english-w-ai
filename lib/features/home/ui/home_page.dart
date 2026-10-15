import 'package:english_learning/config/colors.dart';
import 'package:english_learning/config/widgets.dart';
import 'package:english_learning/features/test/ui/test_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _themeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: Widgets.appBar,
      body: Widgets.scaffoldContainer(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Widgets.text(
                "Данная обучалка помогает расширять словарный запас на английском языке используя ИИ и специальную технику запоминания слов."),
            Widgets.text(
                "Вы вводите тему и начинаете тест. Вам дается тест со словами связанными с введенной темой и их переводами. Отвечайте на вопросы, чтобы проверить свой словарный запас и получить итоговый результат с разбором ошибок."),
            SizedBox(height: 15),
            Widgets.field("Введите тему", _themeController),
            Widgets.button(
              "Начать тест",
              () => Navigator.of(context).pushNamed(
                TestPage.routeName,
                arguments: _themeController.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
