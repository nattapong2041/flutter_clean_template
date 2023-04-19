// Mocks generated by Mockito 5.3.2 from annotations
// in flutter_clean_template/test/news/presentation/view_model/news_view_model_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:flutter_clean_template/features/news/domain/entity/news_result.dart'
    as _i2;
import 'package:flutter_clean_template/features/news/domain/usecase/get_news_usecase.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeNewsResult_0 extends _i1.SmartFake implements _i2.NewsResult {
  _FakeNewsResult_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetNewsUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNewsUseCase extends _i1.Mock implements _i3.GetNewsUseCase {
  @override
  _i4.Future<_i2.NewsResult> execute(_i3.GetNewsParam? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [params],
        ),
        returnValue: _i4.Future<_i2.NewsResult>.value(_FakeNewsResult_0(
          this,
          Invocation.method(
            #execute,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.NewsResult>.value(_FakeNewsResult_0(
          this,
          Invocation.method(
            #execute,
            [params],
          ),
        )),
      ) as _i4.Future<_i2.NewsResult>);
}
