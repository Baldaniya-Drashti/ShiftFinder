import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/contractor/contractor_wallet/contractor_wallet_bloc.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
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
      create: (context) => getIt<ContractorWalletBloc>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: CommonAppBar(
            onBackPressed: () => context.router.maybePop(),
            title: "Wallet",
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: BlocSelector<ContractorWalletBloc, ContractorWalletState, WalletDropdownModel>(
                    selector: (state) => state.initialWalletFilter,
                    builder: (context, initialWalletFilter) {
                      return WalletDropdownField(
                        value: initialWalletFilter,
                        onChanged: (value) {
                          context.read<ContractorWalletBloc>().add(ContractorWalletEvent.onFilterChanged(value: value));
                        },
                      );
                    },
                  ),
                ),
                SliverGap(20),
                SliverToBoxAdapter(
                  child: _WalletInfoSection(),
                ),
                SliverGap(30),
                SliverToBoxAdapter(
                  child: DateRangePickerTile(
                    label: "Period",
                    onDateSelected: (value) {},
                  ),
                ),
                SliverGap(16),
                _TransactionListView()
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _WalletInfoSection extends StatelessWidget {
  const _WalletInfoSection();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _WalletInfoItem(
              icon: SvgImageConstant.availableBalance,
              label: "Available Balance",
              balance: "\$632",
            ),
            _WalletInfoItem(
              icon: SvgImageConstant.withdrawBalance,
              label: "Available Withdrawable Balance",
              balance: "\$200",
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
    required this.icon,
    required this.label,
    required this.balance,
    this.dense = true,
    this.color,
  });

  final String icon;
  final String label;
  final String balance;
  final Color? color;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final effectiveDensity = dense ? VisualDensity.compact : VisualDensity.standard;
    return ListTile(
      dense: dense,
      visualDensity: effectiveDensity,
      leading: SvgPicture.asset(icon, height: 18, width: 18),
      title: BaseText(text: label, fontSize: 12),
      trailing: BaseText(text: balance, textColor: color, fontSize: 14, fontWeight: FontWeight.w600),
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
    final list = <WalletDropdownModel>[
      WalletDropdownModel(id: 1, label: "All Transactions"),
      WalletDropdownModel(id: 2, label: "Earnings"),
      WalletDropdownModel(id: 3, label: "Compensations"),
      WalletDropdownModel(id: 4, label: "Referrals"),
      WalletDropdownModel(id: 5, label: "Deposits"),
    ];

    return CustomDropdownField<WalletDropdownModel>(
      label: "Filter",
      value: value,
      items: list.map(
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

class _TransactionListView extends StatelessWidget {
  const _TransactionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: 25,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: SvgPicture.asset(SvgImageConstant.withdraw,height: 25),
          title: Transform.translate(
            offset: Offset(-8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(text: "12 May, 2024", fontSize: 10),
                BaseText(text: "Deposited to Bank", fontSize: 12,fontWeight: FontWeight.w600,),
              ],
            ),
          ),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseText(text: "+\$560.35",textColor: AppColors.green,fontSize: 14,fontWeight: FontWeight.w600),
              BaseText(text: "Shift Earnings",fontSize: 10),

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
      identical(this, other) || other is WalletDropdownModel && runtimeType == other.runtimeType && id == other.id && label == other.label;

  @override
  int get hashCode => id.hashCode ^ label.hashCode;
}
