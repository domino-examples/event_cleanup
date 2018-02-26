import 'dart:html' as html;
import 'package:domino/domino.dart';
import 'package:domino/html_view.dart';
import 'package:domino/helpers.dart';

typedef bool Condition();

dynamic when(/* bool | Condition */ condition, then, [orElse]) {
  if (condition is Condition) condition = condition();
  if (condition) {
    if (then is Function) return then();
    return then;
  }
  if (orElse is Function) return orElse();
  return orElse;
}

void main() {
  bool state = false;
  registerHtmlView(html.querySelector('#output'), (_) {
    return div([
      when(
          state,
          div(new Element('input',
              [attr('type', 'text'), on('blur', (_) => state = false)])),
          div([
            'Click me!',
            on('click', (_) {
              print('First');
              state = true;
            })
          ])),
      div(div([
        'Another',
        on('click', (_) {
          print('Second');
        })
      ]))
    ]);
  });
}
