class ExpressionValidateResult {
  final bool isSuccess;
  final String messageInfo;

  ExpressionValidateResult(this.isSuccess, this.messageInfo);

  @override
  String toString() {
    return 'ExpressionValidateResult{isSuccess: $isSuccess, messageInfo: $messageInfo}';
  }

}
