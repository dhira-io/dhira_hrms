class Response {
  final String? message;
  final int? status;
  final dynamic data;

  Response({this.message, this.status, this.data});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
        message: json['message'], status: json['status'], data: json['data']);
  }
}