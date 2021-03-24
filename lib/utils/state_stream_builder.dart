import 'package:flutter/material.dart';

class StateStreamBuilder<T> extends StatelessWidget {
  final T initialData;
  final Stream<T> stream;
  final Widget Function() onLoading;
  final Widget Function(T) onSuccess;
  final Widget Function() onFailed;

  const StateStreamBuilder({
    Key key,
    this.initialData,
    this.stream,
    this.onLoading,
    this.onSuccess,
    this.onFailed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return onFailed();
        } else if (!snapshot.hasData) {
          return onLoading();
        } else {
          final data = snapshot.data;
          return onSuccess(data);
        }
      },
    );
  }
}
