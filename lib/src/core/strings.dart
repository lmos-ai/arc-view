//
// String extensions
//
extension Strings on String? {
  // Counts the number of occurrences of a search term in a string.
  count(String searchTerm) {
    if (this == null) return 0;
    return RegExp(searchTerm, caseSensitive: false).allMatches(this!).length;
  }

  // Returns the string if it is not empty, otherwise returns null.
  nullIfEmpty() {
    if (this == null) return null;
    return this!.isEmpty ? null : this;
  }
}
