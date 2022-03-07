import 'dart:async';

class SubscriptionsProvider {
  List _subscriptions = [];

  addSubscription(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }

  cancelSubscriptions() async {
    /* _subscriptions.forEach((subscription) {
      await subscription.cancel();
    });*/
    for (int i = 0; i < _subscriptions.length; i++) {
      await _subscriptions[i].cancel();
    }
  }
}
