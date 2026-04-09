import 'package:url_launcher/url_launcher.dart';

import '../entities/destination_entity.dart';

enum NavigationLaunchStatus { launched, noDestination, failed }

class NavigateToDestinationUsecase {
  const NavigateToDestinationUsecase();

  Future<NavigationLaunchStatus> call(DestinationEntity? destination) async {
    if (destination == null) {
      return NavigationLaunchStatus.noDestination;
    }

    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&destination=${destination.lat},${destination.lng}'
      '&travelmode=driving',
    );
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    return launched
        ? NavigationLaunchStatus.launched
        : NavigationLaunchStatus.failed;
  }
}
