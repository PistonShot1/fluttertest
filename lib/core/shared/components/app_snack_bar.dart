import 'package:flutter/material.dart';
import 'package:fluttertest/core/shared/constant/size_constant.dart';
import 'package:fluttertest/core/shared/style/app_text_style.dart';

/// A utility class for displaying ShadCN UI-inspired snackbars.
class SnackBarUtil {
  /// Global key to access the ScaffoldMessengerState from anywhere.
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  /// Show a ShadCN UI-inspired snackbar with different visual styles based on the alert type.
  ///
  /// [title] The main message to display.
  /// [message] Optional supporting text to show.
  /// [type] The type of alert (success, error, warning, info).
  /// [duration] How long the snackbar should display.
  static void show({
    required String title,
    String? message,
    AlertType type = AlertType.info,
    Duration duration = const Duration(seconds: 4),
  }) {
    if (messengerKey.currentState == null) return;

    final snackBar = SnackBar(
      content: AppSnackBar(title: title, message: message, type: type),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: duration,
      dismissDirection: DismissDirection.horizontal,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

/// The type of alert to display.
enum AlertType { success, error, warning, info }

/// A ShadCN UI-inspired snackbar widget.
class AppSnackBar extends StatelessWidget {
  final String title;
  final String? message;
  final AlertType type;

  const AppSnackBar({
    super.key,
    required this.title,
    this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: _getBackgroundColor(isDark),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getBorderColor(isDark), width: 1),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIcon(isDark),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.getTextStyle(
                    SizeConstant.fontSizeMd,
                    _getTitleColor(isDark),
                    SizeConstant.fontWeightSemiBold,
                  ),
                ),
                if (message != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    message!,
                    style: AppTextStyle.getTextStyle(
                      SizeConstant.fontSizeSm,
                      _getMessageColor(isDark),
                      SizeConstant.fontWeightRegular,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              SnackBarUtil.messengerKey.currentState?.hideCurrentSnackBar();
            },
            child: Icon(
              Icons.close,
              size: 18,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.5)
                  : Colors.black.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(bool isDark) {
    final IconData iconData;
    final Color iconColor;

    switch (type) {
      case AlertType.success:
        iconData = Icons.check_circle;
        iconColor = isDark ? const Color(0xFF22C55E) : const Color(0xFF16A34A);
      case AlertType.error:
        iconData = Icons.cancel;
        iconColor = isDark ? const Color(0xFFF87171) : const Color(0xFFDC2626);
      case AlertType.warning:
        iconData = Icons.warning;
        iconColor = isDark ? const Color(0xFFFBBF24) : const Color(0xFFEA580C);
      case AlertType.info:
        iconData = Icons.info;
        iconColor = isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB);
    }

    return Icon(iconData, color: iconColor, size: 20);
  }

  Color _getBackgroundColor(bool isDark) {
    if (isDark) {
      return const Color(0xFF1F2937); // Dark gray background
    }
    return Colors.white;
  }

  Color _getBorderColor(bool isDark) {
    if (isDark) {
      switch (type) {
        case AlertType.success:
          return const Color(0xFF22C55E).withValues(alpha: 0.2);
        case AlertType.error:
          return const Color(0xFFF87171).withValues(alpha: 0.2);
        case AlertType.warning:
          return const Color(0xFFFBBF24).withValues(alpha: 0.2);
        case AlertType.info:
          return const Color(0xFF60A5FA).withValues(alpha: 0.2);
      }
    }

    switch (type) {
      case AlertType.success:
        return const Color(0xFF22C55E).withValues(alpha: 0.15);
      case AlertType.error:
        return const Color(0xFFDC2626).withValues(alpha: 0.15);
      case AlertType.warning:
        return const Color(0xFFEA580C).withValues(alpha: 0.15);
      case AlertType.info:
        return const Color(0xFF2563EB).withValues(alpha: 0.15);
    }
  }

  Color _getTitleColor(bool isDark) {
    return isDark ? const Color(0xFFF9FAFB) : const Color(0xFF111827);
  }

  Color _getMessageColor(bool isDark) {
    return isDark ? const Color(0xFFD1D5DB) : const Color(0xFF6B7280);
  }
}
