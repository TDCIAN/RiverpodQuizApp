import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_quiz/enums/difficulty.dart';
import 'package:riverpod_quiz/models/question_model.dart';
import 'package:riverpod_quiz/repositories/quiz/base_quiz_repository.dart';
import 'package:equatable/equatable.dart';

class QuizRepository extends BaseQuizRepository {
  final Reader _read;

  QuizRepository(this._read);

  @override
  Future<List<Question>> getQuestions({
    @required int numQuestions,
    @required int categoryId,
    @required Difficulty difficulty,
  }) async {
    try {
      final queryParameters = {
        'type': 'multiple',
        'amount': numQuestions,
        'category': categoryId,
      };

      if (difficulty != Difficulty.any) {
        queryParameters.addAll(
          {
            'difficulty': EnumToString.convertToString(difficulty),
          },
        );
      }

      final response = await _read(dioPovider).get(
        'https://opentdb.com/api.php',
        queryParameters: queryParameters,
      );
    } catch (err) {}
  }
}
