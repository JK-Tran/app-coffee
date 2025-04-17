class SendOtpResponse {
  final String verificationId;
  final bool success;
  final String? message;  

  SendOtpResponse({required this.verificationId, required this.success, this.message, });
}