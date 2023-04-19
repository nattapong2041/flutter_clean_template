# flutter_clean_template

This is my new Flutter project for try Clean Architecture structure.

This project will try to use pub.dev packages as little as possible.

use https://newsapi.org for api source.

## Table of Contents  
[Contact me](#contact)

[Localizationn](#localizations) 

[Model generate](#modelgen) 

[Test guild line](#testguide) 
<a name="contact"></a>
## Confuse somthing in project 
contact me: nattapong.sawa@gmail.com

<a name="localizations"></a>
## Localization 
ref:https://docs.flutter.dev/development/accessibility-and-localization/internationalization

<p>you can edit write the language in lib/localization</p>

<p>you just need to run the project once for generate localization file in .dart_tool</p>


### usage 
example:
```
Text(AppLocalizations.of(context)!.helloWorld);
```
Changing locale anywhere in file
```
context.read<LocaleViewModel>().set(const Locale('en', ''));
```

<a name="modelgen"></a>
## Model generate 
ref:https://pub.dev/packages/json_serializable

ref:https://docs.flutter.dev/development/data-and-backend/json#serializing-json-using-code-generation-libraries

<p>by using this method just write a simple line of code and then the generator will generate file for work with JSON.</p> 

Example with login service
```
must extends base request/response class

@JsonSerializable()
class LoginServiceRequest extends BaseRequest {
    /// some code
}
```
use @JsonKey for modify eg. You can define variable that not the same as json key if need.

For example JsonKey Username will store in id variable

```
@JsonKey(name: 'Username')
String id;
```
after finished write model run the generator 
```
flutter pub run build_runner build
```
or this if conflict occured when builde.
```
flutter pub run build_runner build --delete-conflicting-outputs
```

<a name="testguide"></a>
## Test Guideline 
ref:https://pub.dev/packages/json_serializable
### Unit test
### Widget test
### Integration test
### Test converage

1.Installing Lcov in Mac
```
brew install lcov
```
2.Run tests, generate coverage files 
```
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```
3.Open coverage report in browser
```
open coverage/html/index.html
```