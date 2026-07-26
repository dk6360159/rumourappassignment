import 'package:rumour/core/utilities/monads/result.dart';

typedef ResultFuture<T> =Future<Result<T>>;
typedef ResultVoid= Future<Result<void>>;

typedef DataMap=Map<String,dynamic>;