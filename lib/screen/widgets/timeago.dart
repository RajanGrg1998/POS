class TimeAgo {
  static String timeAgoSinceDate(DateTime time) {
    Duration diff = DateTime.now().difference(time);
    if (diff.inDays >= 2) {
      return '${diff.inDays} days ago';
    } else if (diff.inDays >= 1) {
      return '1 day ago';
    } else if (diff.inHours >= 2) {
      return '${diff.inHours} hours ago';
    } else if (diff.inHours >= 1)
      return '1 hour ago';
    else if (diff.inMinutes >= 2)
      return '${diff.inMinutes} minutes ago';
    else if (diff.inMinutes >= 1)
      return '1 minute ago';
    else if (diff.inSeconds > 3)
      return '${diff.inSeconds} seconds ago';
    else
      return 'Just now';
  }
}
