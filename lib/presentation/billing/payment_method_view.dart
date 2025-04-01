import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/billing/payment_method_bloc/payment_method_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "PaymentMethodView")
class PaymentMethodView extends StatelessWidget {
  const PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PaymentMethodBloc>()
        ..add(PaymentMethodEvent.getCardList(context)),
      child: BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: StringConstant.paymentMethods,
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.surfaceColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                              EdgeInsets.all(12).copyWith(left: 16, right: 16),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                SvgImageConstant.securePayment,
                                height: getSize(40),
                                width: getSize(54),
                                colorFilter: ColorFilter.mode(
                                    AppColors.green, BlendMode.srcIn),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getSize(15)),
                                child: Image.asset(
                                  PngImageConstants.line,
                                  height: getSize(80),
                                ),
                              ),
                              Expanded(
                                child: BaseText(
                                  text: StringConstant.paymentMethodDesc,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (state.isLoading)
                          CenterLoadingIndicator(isOnlyLoader: true)
                        else if (state.cardList.isNotEmpty) ...[
                          Padding(
                            padding: EdgeInsets.only(
                                left: getSize(18),
                                top: getSize(30),
                                bottom: getSize(15)),
                            child: BaseText(
                              text: StringConstant.creditAndDebitCards,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                Gap(getSize(16)),
                            itemCount: state.cardList.length,
                            itemBuilder: (context, index) => cardTile(
                              cardNumber: state.cardList[index].number ?? "",
                              icon: state.cardList[index].icon,
                              onCardDelete: () {
                                context.read<PaymentMethodBloc>().add(
                                    PaymentMethodEvent.deleteCardEvent(context,
                                        state.cardList[index].id ?? -1));
                              },
                            ),
                          ),
                        ],
                        Gap(getSize(20)),
                        Align(
                          alignment: Alignment.center,
                          child: CommonButton(
                            height: 35,
                            width: 135,
                            onPressed: () {
                              context.router
                                  .push(PageRouteInfo(AddCardDetailPage.name,
                                      args: AddCardDetailPageArgs(
                                        fromRegister: false,
                                      )))
                                  .then((value) {
                                if (value == true) {
                                  context.read<PaymentMethodBloc>().add(
                                      PaymentMethodEvent.getCardList(context));
                                }
                              });
                            },
                            backgroundColor:
                                AppColors.green.withValues(alpha: 0.15),
                            buttonText: '+ ${StringConstant.addNewCard}',
                            buttonTextColor: AppColors.green,
                            buttonFontSize: 12,
                            borderRadius: 7,
                            buttonFontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state.isDeleting) CenterLoadingIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget cardTile({
    required String cardNumber,
    required String? icon,
    required void Function()? onCardDelete,
  }) {
    return ListTile(
      tileColor: AppColors.white,
      leading: (icon != null && icon.isNotEmpty)
          ? SvgPicture.network(
              icon,
              height: getSize(15),
              width: getSize(15),
            )
          : SvgPicture.asset(
              SvgImageConstant.card,
              height: getSize(15),
              width: getSize(15),
            ),
      title: BaseText(
        text: cardNumber,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      trailing: InkWell(
        onTap: onCardDelete,
        child: SvgPicture.asset(
          SvgImageConstant.bin,
        ),
      ),
    );
  }
}
