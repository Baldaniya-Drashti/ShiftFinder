import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class NetworkListener {
  static final NetworkListener _instance = NetworkListener._internal();
  factory NetworkListener() => _instance;
  NetworkListener._internal();

  static bool isDialogShowing = false;
  GlobalKey<NavigatorState>? _navigatorKey;
  static VoidCallback? _queuedNavigation;

  void initialize() {
    _navigatorKey = getIt<AppRouter>().navigatorKey;
    _listenToNetworkChanges();
  }

  void _listenToNetworkChanges() {
    Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      if (results.contains(ConnectivityResult.none)) {
        _showNoInternetDialog();
      } else {
        _dismissNoInternetDialog();
        _queuedNavigation?.call();
        _queuedNavigation = null;
      }
    });
  }

  Future<void> navigateWhenOnline(
      Future<void> Function() navigationCallback) async {
    final result = await Connectivity().checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      _queuedNavigation = navigationCallback;
      _showNoInternetDialog();
    } else {
      await navigationCallback();
    }
  }

  void _showNoInternetDialog() {
    if (!isDialogShowing && _navigatorKey?.currentContext != null) {
      isDialogShowing = true;
      showDialog(
        context: _navigatorKey!.currentContext!,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              backgroundColor: AppColors.white,
              insetPadding: EdgeInsets.symmetric(horizontal: getSize(20)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: _buildAnimatedIcon(dialogContext),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BaseText(
                    text: StringConstant.noInternetConnection,
                    fontSize: 22,
                    textColor: AppColors.redAccent,
                    textAlign: TextAlign.center,
                  ),
                  BaseText(
                    text: StringConstant.pleaseTryAgainLater,
                    fontSize: 16,
                    textAlign: TextAlign.center,
                    textColor: AppColors.black.withValues(alpha: 0.5),
                  ),
                ],
              ),
            ),
          );
        },
      ).then((_) {
        isDialogShowing = false;
      });
    }
  }

  Widget _buildAnimatedIcon(BuildContext dialogContext) {
    return Builder(
      builder: (BuildContext context) {
        final AnimationController controller = AnimationController(
          duration: const Duration(seconds: 1),
          vsync: Navigator.of(dialogContext),
        )..repeat(reverse: true);

        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (controller.value * 0.2),
              child: Icon(
                Icons.wifi_off,
                color: AppColors.redAccent,
                size: getSize(90),
              ),
            );
          },
        );
      },
    );
  }

  void _dismissNoInternetDialog() {
    if (isDialogShowing && _navigatorKey?.currentContext != null) {
      isDialogShowing = false;
      Navigator.of(_navigatorKey!.currentContext!, rootNavigator: true).pop();
    }
  }
}
