class KaizenList {
  final String listId;
  final String listTitle;
  final String listDescription;
  final int numberOfCards;
  bool isSelected;

  KaizenList(this.listTitle, this.listDescription, this.listId, this.isSelected,
      this.numberOfCards);
}
