bool isValidLink(String? link) {
  if (link == null) return false;
  final trimmed = link.trim();
  if (trimmed.isEmpty) return false;

  final uri = Uri.tryParse(trimmed);
  if (uri == null || !uri.hasScheme || !uri.hasAuthority) return false;

  return true;
}
