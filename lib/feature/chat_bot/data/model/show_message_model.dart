class ShowMessageModel {
  ShowMessageModel({
    required this.message,
    required this.role,
    this.isLoading = false,
    this.isError = false,
  });

  final String message;
  final String role;
  final bool isLoading;
  final bool isError;
}
