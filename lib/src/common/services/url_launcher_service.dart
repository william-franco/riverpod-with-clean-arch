import 'package:url_launcher/url_launcher.dart';

abstract interface class UrlLauncherService {
  Future<void> openUrl({required Uri url});
}

class UrlLauncherServiceImpl implements UrlLauncherService {
  @override
  Future<void> openUrl({required Uri url}) async {
    try {
      final bool launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        throw Exception('Could not launch $url');
      }
    } catch (error) {
      throw Exception('UrlLauncherService: $error');
    }
  }
}
