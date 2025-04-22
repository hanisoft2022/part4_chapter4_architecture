import 'package:fast_app_base/common/util/simple_result.dart';

import '../entity/entity.dart';

abstract interface class TodoRepository<Error> {
  Future<SimpleResult<List<Todo>, Error>> getTodoList();
  Future<SimpleResult<void, Error>> addTodo(Todo todo);
  Future<SimpleResult<void, Error>> updateTodo(Todo todo);
  Future<SimpleResult<void, Error>> removeTodo(int id);
}
