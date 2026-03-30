import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/contractor/contractor_wallet/contractor_wallet_bloc.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/contractor_main/earning/contractor_wallet_dto/contractor_wallet_dto.dart';
import 'package:shift/infrastructure/contractor_main/earning/get_balance_dto/get_balance_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/date_range_picker_tile.dart';
import 'package:shift/presentation/core/widgets/drop_down_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

import '../../domain/core/math_utils.dart';

@RoutePage(name: "ContractorWalletView")
class ContractorWalletView extends StatelessWidget {
  const ContractorWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContractorWalletBloc>()
        ..add(ContractorWalletEvent.getAvailableBalance())
        ..add(ContractorWalletEvent.getWalletList(true, context)),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: CommonAppBar(
            onBackPressed: () => context.router.maybePop(),
            title: StringConstant.wallet,
          ),
          body: BlocBuilder<ContractorWalletBloc, ContractorWalletState>(
            builder: (context, state) {
              return (state.isLoading)
                  ? CenterLoadingIndicator(isOnlyLoader: true)
                  : PaginatedListView(
                      onRefresh: () {
                        context.read<ContractorWalletBloc>().add(
                            ContractorWalletEvent.getWalletList(true, context));
                      },
                      refreshController: context
                          .read<ContractorWalletBloc>()
                          .refreshController,
                      onLoading: () {
                        context.read<ContractorWalletBloc>().add(
                            ContractorWalletEvent.getWalletList(
                                false, context));
                      },
                      isNoDataFound: false,
                      child: state.isLoading
                          ? CenterLoadingIndicator(isOnlyLoader: true)
                          : state.isErrorInApi
                              ? Center(
                                  child: BaseText(
                                      text: StringConstant.somethindWentWrong),
                                )
                              : Padding(
                                  padding: EdgeInsets.all(getSize(16)),
                                  child: CustomScrollView(
                                    slivers: [
                                      if (state.initialWalletFilter.id !=
                                          0) ...[
                                        SliverToBoxAdapter(
                                          child: WalletInfoWithDifferentLayout(
                                            balance: state.currentBalance,
                                          ),
                                        ),
                                        SliverGap(getSize(12)),
                                      ],
                                      SliverToBoxAdapter(
                                        child: BlocSelector<
                                            ContractorWalletBloc,
                                            ContractorWalletState,
                                            WalletDropdownModel>(
                                          selector: (state) =>
                                              state.initialWalletFilter,
                                          builder:
                                              (context, initialWalletFilter) {
                                            return WalletDropdownField(
                                              value: initialWalletFilter,
                                              onChanged: (value) {
                                                context
                                                    .read<
                                                        ContractorWalletBloc>()
                                                    .add(ContractorWalletEvent
                                                        .onFilterChanged(
                                                            context,
                                                            value: value));
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      SliverGap(20),
                                      if (state.initialWalletFilter.id ==
                                          0) ...[
                                        SliverToBoxAdapter(
                                          child: WalletInfoSection(
                                            balance: state.currentBalance,
                                          ),
                                        ),
                                        SliverGap(getSize(20)),
                                      ] else ...[
                                        SliverToBoxAdapter(
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColors.white,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.all(getSize(20)),
                                              child: _WalletInfoItem(
                                                icon: SvgImageConstant
                                                    .availableBalance,
                                                label: StringConstant
                                                    .availableBalance,
                                                balance:
                                                    "\$${state.currentBalance?.available_balance ?? 0.0}",
                                              ),
                                            ),
                                          ),
                                        ),
                                        SliverGap(18),
                                      ],
                                      SliverToBoxAdapter(
                                        child: DateRangePickerTile(
                                          selectedDate: state.selectedDateTime,
                                          label: StringConstant.period,
                                          onDateSelected: (value) {
                                            context
                                                .read<ContractorWalletBloc>()
                                                .add(ContractorWalletEvent
                                                    .onDateSelected(context,
                                                        dates: value));
                                          },
                                        ),
                                      ),
                                      if (!state.noDataFound) ...[
                                        SliverGap(getSize(16)),
                                        TransactionListView(
                                            walletList: state.walletList),
                                      ],
                                      if (state.initialWalletFilter.id == 0)
                                        SliverToBoxAdapter(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: getSize(10),
                                                vertical: getSize(22)),
                                            child: CommonButton(
                                              onPressed: () {
                                                context.router
                                                    .push(PageRouteInfo(
                                                        ContractorWithdrawPaymentView
                                                            .name))
                                                    .then((value) {
                                                  if (value == true) {
                                                    context
                                                        .read<
                                                            ContractorWalletBloc>()
                                                        .add(
                                                            ContractorWalletEvent
                                                                .getWalletList(
                                                                    true,
                                                                    context));
                                                  }
                                                });
                                              },
                                              buttonText: StringConstant
                                                  .withdrawPayment,
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                    );
            },
          ),
        );
      }),
    );
  }
}

class WalletInfoWithDifferentLayout extends StatelessWidget {
  final GetBalanceDTO? balance;
  const WalletInfoWithDifferentLayout({super.key, this.balance});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceColor,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: EdgeInsets.all(getSize(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _WalletInfoItem(
              label: StringConstant.availableBalance,
              balance: "\$${balance?.available_balance ?? 0.0}",
            ),
            Gap(getSize(16)),
            _WalletInfoItem(
              label: StringConstant.availableWithdrawableBalance,
              balance: "\$${balance?.available_withdrawable_balance ?? 0.0}",
              color: AppColors.green,
            ),
            Gap(getSize(16)),
            _WalletInfoItem(
              label: StringConstant.lastDeposit,
              balance: "\$${balance?.pending_balance ?? 0.0}",
              color: AppColors.redAccent,
            ),
            Gap(getSize(24)),
            CommonButton(
              borderRadius: 7,
              onPressed: () {
                context.router
                    .push(PageRouteInfo(ContractorWithdrawPaymentView.name))
                    .then((value) {
                  if (value == true) {
                    context.read<ContractorWalletBloc>().add(
                        ContractorWalletEvent.getWalletList(true, context));
                  }
                });
              },
              buttonText: StringConstant.withdrawPayment,
              buttonFontWeight: FontWeight.w400,
              buttonFontSize: 14,
            ),
          ],
        ),
      ),
    );
  }
}

class WalletInfoSection extends StatelessWidget {
  final GetBalanceDTO? balance;
  const WalletInfoSection({super.key, this.balance});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: EdgeInsets.all(getSize(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _WalletInfoItem(
              icon: SvgImageConstant.availableBalance,
              label: StringConstant.availableBalance,
              balance: "\$${balance?.available_balance ?? 0.0}",
            ),
            Gap(16),
            _WalletInfoItem(
              icon: SvgImageConstant.availableWithdrawBalance,
              label: StringConstant.availableWithdrawableBalance,
              balance: "\$${balance?.available_withdrawable_balance ?? 0.0}",
              color: AppColors.green,
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletInfoItem extends StatelessWidget {
  const _WalletInfoItem({
    this.icon,
    required this.label,
    required this.balance,
    this.color,
  });

  final String? icon;
  final String label;
  final String balance;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          SvgPicture.asset(
            icon!,
            height: 18,
            width: 18,
            colorFilter: ColorFilter.mode(
                AppColors.black.withValues(alpha: 0.8), BlendMode.srcIn),
          ),
          Gap(10),
        ],
        Expanded(
          child: BaseText(
            text: label,
            fontSize: 12,
            textColor: AppColors.black.withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
        BaseText(
            text: balance,
            textColor: color,
            fontSize: 14,
            fontWeight: FontWeight.w600)
      ],
    );
  }
}

class WalletDropdownField extends StatelessWidget {
  const WalletDropdownField({
    super.key,
    required this.onChanged,
    this.value,
  });

  final void Function(WalletDropdownModel value) onChanged;
  final WalletDropdownModel? value;

  @override
  Widget build(BuildContext context) {
    return CustomDropdownField<WalletDropdownModel>(
      label: StringConstant.filter,
      value: value,
      items: CommonList.walletList.map(
        (e) {
          return DropdownMenuItem<WalletDropdownModel>(
            value: e,
            child: BaseText(
              text: e.label,
              fontWeight: FontWeight.w500,
              fontSize: getSize(14),
            ),
          );
        },
      ).toList(),
      onChanged: (value) => onChanged(value as WalletDropdownModel),
    );
  }
}

class TransactionListView extends StatelessWidget {
  final List<ContractorWalletDTO> walletList;
  const TransactionListView({super.key, required this.walletList});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: walletList.length,
      itemBuilder: (context, index) {
        final wallet = walletList[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: SvgPicture.asset(
            (wallet.type == 4)
                ? SvgImageConstant.withdraw
                : SvgImageConstant.deposited,
            height: 25,
          ),
          title: Transform.translate(
            offset: Offset(-8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                    text: DateFormat("dd MMM, yyyy").format(
                        CustomDateTimeFormat.timeStampToDateTime(
                            (wallet.created ?? -1))),
                    fontSize: 10),
                BaseText(
                  text:
                      "${(wallet.type == 1 || wallet.type == 2) ? wallet.company_name : wallet.filter_name}",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseText(
                  text:
                      "\$${(wallet.type == 4) ? "-" : ""}${wallet.amount?.toStringAsFixed(2)}",
                  textColor: (wallet.type == 4)
                      ? AppColors.redAccent
                      : AppColors.green,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              if (wallet.type == 1 || wallet.type == 2)
                BaseText(text: wallet.filter_name ?? "", fontSize: 10),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(height: 0),
    );
  }
}

class WalletDropdownModel {
  final int id;
  final String label;

  const WalletDropdownModel({
    required this.id,
    required this.label,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletDropdownModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          label == other.label;

  @override
  int get hashCode => id.hashCode ^ label.hashCode;
}
