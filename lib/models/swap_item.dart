class SwapItem {
  SwapItem({required this.horizontalSpace, required this.verticalSpace});
  final double horizontalSpace;
  final double verticalSpace;

  SwapItem copyWith({double? horizontalSpace, double? verticalSpace}) {
    return SwapItem(
        horizontalSpace: horizontalSpace ?? this.horizontalSpace,
        verticalSpace: verticalSpace ?? this.verticalSpace);
  }
}
