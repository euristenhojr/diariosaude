import 'package:flutter/material.dart';
import 'package:materno_infantil/models/child_model.dart';
import 'package:materno_infantil/models/event_model.dart';
import 'package:materno_infantil/models/user_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:materno_infantil/ui/home_page.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return ScopedModel<ChildModel>(
          model: ChildModel(model),
          child: ScopedModelDescendant<ChildModel>(builder: (context, child, childModel) {
            return ScopedModel<EventModel>(
              model: EventModel(model),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: HomePage(),
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                supportedLocales: [const Locale('pt', 'BR')],
              ),
            );
          }),
        );
      }),
    );
  }
}
