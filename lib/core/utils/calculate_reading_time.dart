int calculateReadingTime(String content) {
  final words = content.split(' ');
  final time = words.length / 200;
  return time.ceil();
}
