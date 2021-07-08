import 'package:url_launcher/url_launcher.dart';

//For Launching Any URL with url_launcher
void launchThisUrl(String _url) async {
  await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}
