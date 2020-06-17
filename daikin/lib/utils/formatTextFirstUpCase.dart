
String upFirstText(String text) {
  if (text != null && text.length > 1) {
    return text[0].toUpperCase() + text?.substring(1)?.toLowerCase();
  } else {
    return text != null ? text?.toUpperCase() : '';
  }
}

String uppercaseFirstInWord(String text) {
  String ret = text.trim().split(' ')
      .map((item) {
        return item.trim().isNotEmpty ? '${item[0].toUpperCase()}${item.substring(1)}' : ''; })
      .toList()
      .join(' ');
  return ret;
}
