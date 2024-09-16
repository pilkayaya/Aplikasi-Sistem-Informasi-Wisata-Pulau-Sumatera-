class ApiException{
  final String message;
  ApiException({required this.message});

  @override
  String toString(){
    return message;
  }
}