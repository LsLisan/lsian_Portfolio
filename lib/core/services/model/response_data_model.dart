class ResponseDataModel {
  final bool isSuccess;
  final int statusCode;
  final String errorMessage;
  final dynamic responseData;

  ResponseDataModel({
    required this.isSuccess,
  required this.statusCode,
  required this.errorMessage,
  this.responseData});
}