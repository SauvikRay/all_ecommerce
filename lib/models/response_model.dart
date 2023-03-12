class ResponseModel{
  bool _isSuccess;
  String _message;
  String _status;

  ResponseModel(
    this._isSuccess,
    this._message,
    this._status
  );

  String get message => _message;
  String get status => _status;
  bool get isSuccess => _isSuccess;

}