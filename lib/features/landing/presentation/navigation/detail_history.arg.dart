class DetailHistoryArg {
  const DetailHistoryArg({
    required this.transNo,
    this.isFromHistory = false,
  });

  final String transNo;
  final bool isFromHistory;
}
