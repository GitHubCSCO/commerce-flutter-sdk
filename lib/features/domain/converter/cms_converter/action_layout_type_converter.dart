enum ActionsLayout { list, grid }

class ActionsLayoutConverter {
  static ActionsLayout convert(String enumString) {
    switch (enumString.toLowerCase()) {
      case "list":
        return ActionsLayout.list;
      case "grid":
        return ActionsLayout.grid;
      default:
        return ActionsLayout.list;
    }
  }
}
