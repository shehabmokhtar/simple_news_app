import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../layout/Cubit/Cubit.dart';
import '../../layout/Cubit/States.dart';
import '../../modules/webView/WebView.dart';

class Defaultbotton extends StatelessWidget {
  const Defaultbotton(
      {super.key,
      this.background = Colors.blue,
      this.width = double.infinity,
      required this.text,
      this.radius = 5.0,
      required this.onPress});

  final double width;
  final Color background;
  final String text;
  final double radius;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: onPress,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
  }
}

class BuildArticleItems extends StatelessWidget {
  final Map<dynamic, dynamic> articles;

  const BuildArticleItems({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          WebViewScreen(articles['url']),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    NewsCubit.get(context).imageDisplay(articles['urlToImage']),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: SizedBox(
                height: 120.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        articles['title'],
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                    Text(
                      articles['publishedAt'],
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget Artical_Row(artical, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(artical['url']));
      },
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          '${artical['urlToImage'] ?? 'https://wallpaperaccess.com/full/3551760.jpg'}'))),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${artical['title']}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Text(
                    '${artical['publishedAt']}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget ArticleBuilder(list, context) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Artical_Row(list[index], context),
        separatorBuilder: (context, index) => const MyDivider(),
        itemCount: list.length,
      ),
      fallback: (context) => const Center(child: CircularProgressIndicator()),
    );

void navigateTo(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return screen;
      },
    ),
  );
}

class CostumTextFormFeild extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String label;
  final dynamic onSubmit;
  final dynamic onChange;
  final dynamic onTap;
  final dynamic validate;
  final dynamic prefix;
  final dynamic suffix;
  final dynamic suffixPressed;
  final bool isPassword;

  const CostumTextFormFeild({
    super.key,
    required this.label,
    required this.controller,
    required this.type,
    required this.prefix,
    this.onSubmit,
    this.onChange,
    required this.validate,
    this.onTap,
    this.suffixPressed,
    this.suffix,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
        suffixIcon: Icon(suffix),
        prefixIcon: GestureDetector(
          onTap: suffixPressed,
          child: Icon(
            prefix,
          ),
        ),
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
