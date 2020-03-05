String upFirstText(String text) {
  if (text != null && text.length > 1) {
    return text[0].toUpperCase() + text?.substring(1)?.toLowerCase();
  } else {
    return text != null ? text?.toUpperCase() : null;
  }
}
