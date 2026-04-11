import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ApplicationBar extends StatelessWidget {
  final String title;
  final bool isShowBack;

  const ApplicationBar({
    super.key,
    required this.title,
    this.isShowBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Row(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: Container(
              child: isShowBack
                  ? GestureDetector(
                      onTap: () => context.pop(),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        size: 30,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                  : Container(),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
          SizedBox(height: 50, width: 50, child: Container()),
        ],
      ),
    );
  }
}
