import 'package:fast_app_base/domain/model/todo.dart';

import 'entity/entity.dart';

/// ENTITY -> MODEL
extension TodoDbModelEx on TodoDbModel {
  Todo toModel() {
    return Todo(
      id: id,
      title: title,
      dueDate: dueDate,
      createdTime: createdTime,
      status: status,
      modifyTime: modifyTime,
    );
  }
}

extension TodoDTOEx on TodoDTO {
  Todo toModel() {
    return Todo(
      id: id,
      title: title,
      dueDate: dueDate,
      createdTime: createdTime,
      status: status,
      modifyTime: modifyTime,
    );
  }
}

/// MODEL -> ENTITY
extension TodoEx on Todo {
  TodoDbModel toDbModel() {
    return TodoDbModel(
      id,
      createdTime,
      modifyTime,
      title,
      dueDate,
      status,
    );
  }

  TodoDTO toDTO() {
    return TodoDTO(
      id: id,
      createdTime: createdTime,
      modifyTime: modifyTime,
      title: title,
      dueDate: dueDate,
      status: status,
    );
  }
}
