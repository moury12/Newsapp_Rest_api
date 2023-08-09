class HttpStatusErrorHandle{
  final int status;

  HttpStatusErrorHandle( {required this.status});
  String get getStatusError{
    if(status==400){
      return 'The request was unacceptable, often due to a missing or misconfigured parameter.';
    } else if(status==401){
      return 'Your API key was missing from the request, or wasn\'t correct.';
    }else if(status==429){
      return 'You made too many requests within a window of time and have been rate limited. Back off for a while.';
    }else if(status==500){
      return 'Something went wrong on our side.';
    }return "";
  }
  @override
  String toString() {
    return getStatusError;
  }

}