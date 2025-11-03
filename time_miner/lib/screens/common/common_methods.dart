import 'package:url_launcher/url_launcher.dart';

class CommonMethods {
  static String formatTimestamp(int? timestamp) {
    if (timestamp == null || timestamp == 0) return '';
    final dt = DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();
    final months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final month = months[dt.month];
    final day = dt.day;
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '$month $day, $hour:$minute $ampm';
  }

  static String formatCallDuration(int seconds) {
  if (seconds <= 0) return '0s';

  final int hours = seconds ~/ 3600;
  final int minutes = (seconds % 3600) ~/ 60;
  final int secs = seconds % 60;

  final buffer = StringBuffer();

  if (hours > 0) buffer.write('${hours}h');
  if (minutes > 0) buffer.write('${minutes}m');
  if (secs > 0 || (hours == 0 && minutes == 0)) buffer.write('${secs}s');

  return buffer.toString();
}

  static Future<void> launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
