import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hastools/core/constants/color.dart';
import 'package:network_logger/network_logger.dart';

class NetworkLoggerManager {
  static final NetworkLoggerManager _instance =
      NetworkLoggerManager._internal();
  bool _isInitialized = false;

  factory NetworkLoggerManager() {
    return _instance;
  }

  NetworkLoggerManager._internal();

  void initializeLogger(BuildContext context) {
    if (!_isInitialized) {
      NetworkLoggerOverlay.attachTo(context, draggable: true);
      _isInitialized = true;
    }
  }
}

class NetworkLoggerWrapper extends StatefulWidget {
  final Widget child;

  const NetworkLoggerWrapper({super.key, required this.child});

  @override
  State<NetworkLoggerWrapper> createState() => _NetworkLoggerWrapperState();
}

class _NetworkLoggerWrapperState extends State<NetworkLoggerWrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NetworkLoggerManager().initializeLogger(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget child;
  final bool showBackButton;
  final bool enablePullRefresh;
  final bool enableLoadMore;
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoadMore;
  final VoidCallback? onBack;
  final Widget? headerRight;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool withBottomNavigation;
  final int? currentIndex;
  final Function(int)? onNavigate;
  final bool backExit;

  const AppScaffold({
    super.key,
    this.title,
    required this.child,
    this.showBackButton = true,
    this.enablePullRefresh = false,
    this.enableLoadMore = false,
    this.onRefresh,
    this.onLoadMore,
    this.onBack,
    this.headerRight,
    this.backgroundColor = const Color.fromARGB(255, 240, 239, 239),
    this.resizeToAvoidBottomInset = true,
    this.withBottomNavigation = false,
    this.currentIndex,
    this.onNavigate,
    this.backExit = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = child;

    if (enableLoadMore && onLoadMore != null) {
      content = NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            onLoadMore!();
          }
          return true;
        },
        child: content,
      );
    }

    if (enablePullRefresh && onRefresh != null) {
      content = RefreshIndicator(
        onRefresh: onRefresh!,
        child: content,
      );
    }

    return PopScope(
      canPop: backExit,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          await SystemNavigator.pop(animated: true);
          return;
        }
        if (onBack != null) {
          onBack!();
        } else if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          context.go('/');
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: title != null
            ? AppBar(
                title: Text(title!),
                backgroundColor: Colors.white,
                scrolledUnderElevation: 0.0,
                leading: showBackButton
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          if (onBack != null) {
                            onBack!();
                          } else if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          } else {
                            context.go('/');
                          }
                        },
                      )
                    : null,
                actions: headerRight != null ? [headerRight!] : null,
              )
            : null,
        body: SafeArea(child: content),
        bottomNavigationBar: withBottomNavigation
            ? BottomNavigationBar(
                currentIndex: currentIndex ?? 0,
                selectedItemColor: AppColors.accent,
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.work),
                    label: 'Tools',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
                onTap: onNavigate,
              )
            : null,
      ),
    );
  }
}
