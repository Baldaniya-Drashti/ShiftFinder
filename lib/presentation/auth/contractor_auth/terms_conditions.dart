// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'termsAndConditionsScreen')
class TermsAndConditionsScreen extends StatelessWidget {
  TermsAndConditionsScreen({super.key});
  var htmlData = r"""
<p id='top'><a href='#bottom'>Scroll to bottom</a></p>
     <img src="https://www.w3schools.com/images/w3schools_green.jpg" alt="W3Schools.com">

""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () {
            context.router.maybePop();
          },
          title: StringConstant.termsAndConditions,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Html(
                data: htmlData,
              ),
              CommonButton(
                onPressed: () {
                  context.router
                      .push(const PageRouteInfo(IntroVideoScreen.name));
                },
                buttonText: StringConstant.txtContinue,
              ),
            ],
          ),
        ));
  }
}
