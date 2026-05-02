typedef NowProvider = DateTime Function();

DateTime systemNow() => DateTime.now().toUtc();
