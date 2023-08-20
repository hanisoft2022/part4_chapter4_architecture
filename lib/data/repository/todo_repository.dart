import 'package:dio/dio.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/data/source/local/error/local_db_error.dart';
import 'package:fast_app_base/data/source/remote/result/api_error.dart';
import 'package:fast_app_base/domain/domain.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

import '../entity/vo_todo.dart';
import '../simple_result.dart';
import '../source/local/todo_db.dart';
import '../source/remote/todo_api.dart';

/// Remote
class TodoRemoteRepository implements TodoRepository<ApiError> {
  final TodoApi _api;

  TodoRemoteRepository([TodoApi? api]) : _api = api ?? Get.find();

  @override
  Future<SimpleResult<List<Todo>, ApiError>> getTodoList() async {
    return tryRequest(() async {
      final todoList = await _api.getTodoList();
      return SimpleResult.success(todoList);
    });
  }

  @override
  Future<SimpleResult<void, ApiError>> addTodo(Todo todo) async {
    return tryRequest(() async {
      await _api.addTodo(todo);
      return SimpleResult.success();
    });
  }

  @override
  Future<SimpleResult<void, ApiError>> updateTodo(Todo todo) async {
    return tryRequest(() async {
      await _api.updateTodo(todo);
      return SimpleResult.success();
    });
  }

  @override
  Future<SimpleResult<void, ApiError>> removeTodo(int id) async {
    return tryRequest(() async {
      await _api.removeTodo(id);
      return SimpleResult.success();
    });
  }

  Future<SimpleResult<T, ApiError>> tryRequest<T>(Future<SimpleResult<T, ApiError>> Function() apiLogic) async {
    try {
      return await apiLogic();
    } on DioException catch (e) {
      return SimpleResult.failure(ApiError(
          message: e.message ?? e.error?.toString() ?? 'error message is not exist',
          statusCode: e.response?.statusCode ?? 0));
    } catch (e) {
      return SimpleResult.failure(ApiError(message: 'unknown error ${e.toString()}'));
    }
  }
}

/// Local
class TodoLocalRepository implements TodoRepository<LocalDBError> {
  final TodoDB _db;

  TodoLocalRepository([TodoDB? db]) : _db = db ?? Get.find();

  @override
  Future<SimpleResult<List<Todo>, LocalDBError>> getTodoList() => _db.getTodoList();

  @override
  Future<SimpleResult<void, LocalDBError>> addTodo(Todo todo) => _db.addTodo(todo);

  @override
  Future<SimpleResult<void, LocalDBError>> updateTodo(Todo todo) => _db.updateTodo(todo);

  @override
  Future<SimpleResult<void, LocalDBError>> removeTodo(Id id) => _db.removeTodo(id);
}
