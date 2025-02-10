import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// This class simplyfies the output of the logger package.
/// It is used to print the logs in a more readable format.
@immutable
class _SimpleLogPrinter extends LogPrinter {
  /// This is the constructor of the [_SimpleLogPrinter] class.
  _SimpleLogPrinter(
    this.className, {
    this.printCallingFunctionName = true,
    this.printCallStack = false,
    this.exludeLogsFromClasses = const [],
    this.showOnlyClass,
  });

  /// This is the name of the class that is using the logger.
  final String className;

  /// This is a flag that indicates if the name of the calling function
  /// should be printed.
  final bool printCallingFunctionName;

  /// This is a flag that indicates if the call stack should be printed.
  final bool printCallStack;

  /// This is a list of classes that should be excluded from the logs.
  final List<String> exludeLogsFromClasses;

  /// This is a class that should be the only one to be printed.
  final String? showOnlyClass;

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter().levelColors![event.level];
    final emoji = PrettyPrinter().levelEmojis![event.level];
    final methodName = _getMethodName();

    final methodNameSection =
        printCallingFunctionName && methodName != null ? ' | $methodName ' : '';
    final stackLog = event.stackTrace.toString();
    final output =
        '''$emoji $className$methodNameSection - ${event.message}${printCallStack ? stackLog != 'null' ? '\nSTACKTRACE:\n$stackLog' : '' : ''}''';

    if (exludeLogsFromClasses
            .any((excludeClass) => className == excludeClass) ||
        (showOnlyClass != null && className != showOnlyClass)) {
      return [];
    }

    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    final result = <String>[];

    for (final line in output.split('\n')) {
      result.addAll(
        pattern.allMatches(line).map((match) {
          if (kReleaseMode) {
            return match.group(0)!;
          } else {
            return color!(match.group(0)!);
          }
        }),
      );
    }

    return result;
  }

  String? _getMethodName() {
    try {
      final currentStack = StackTrace.current;
      final formattedStacktrace = _formatStackTrace(currentStack, 3);
      if (kIsWeb) {
        final classNameParts = _splitClassNameWords(className);
        return _findMostMatchedTrace(formattedStacktrace!, classNameParts)
            .split(' ')
            .last;
      } else {
        final realFirstLine = formattedStacktrace
            ?.firstWhere((line) => line.contains(className), orElse: () => '');

        final methodName = realFirstLine?.replaceAll('$className.', '');
        return methodName;
      }
    } catch (e) {
      // There's no deliberate function call from our code so we return null;
      return null;
    }
  }

  List<String> _splitClassNameWords(String className) {
    return className
        .split(RegExp('(?=[A-Z])'))
        .map((e) => e.toLowerCase())
        .toList();
  }

  /// When the faulty word exists in the begging this method will
  /// not be very useful.
  String _findMostMatchedTrace(
    List<String> stackTraces,
    List<String> keyWords,
  ) {
    var match = stackTraces.firstWhere(
      (trace) => _doesTraceContainsAllKeywords(trace, keyWords),
      orElse: () => '',
    );
    if (match.isEmpty) {
      match = _findMostMatchedTrace(
        stackTraces,
        keyWords.sublist(0, keyWords.length - 1),
      );
    }
    return match;
  }

  bool _doesTraceContainsAllKeywords(String stackTrace, List<String> keywords) {
    final formattedKeywordsAsRegex = RegExp(keywords.join('.*'));
    return stackTrace.contains(formattedKeywordsAsRegex);
  }
}

/// This is a regex that is used to format the stack trace.
final stackTraceRegex = RegExp(r'#[0-9]+[\s]+(.+) \(([^\s]+)\)');

List<String>? _formatStackTrace(StackTrace stackTrace, int methodCount) {
  final lines = stackTrace.toString().split('\n');

  final formatted = <String>[];
  var count = 0;
  for (final line in lines) {
    final match = stackTraceRegex.matchAsPrefix(line);
    if (match != null) {
      if (match.group(2)!.startsWith('package:logger')) {
        continue;
      }
      final newLine = '${match.group(1)}';
      formatted.add(newLine.replaceAll('<anonymous closure>', '()'));
      if (++count == methodCount) {
        break;
      }
    } else {
      formatted.add(line);
    }
  }

  if (formatted.isEmpty) {
    return null;
  } else {
    return formatted;
  }
}

class _MultipleLoggerOutput extends LogOutput {
  _MultipleLoggerOutput(this.logOutputs);
  final List<LogOutput> logOutputs;

  @override
  void output(OutputEvent event) {
    for (final logOutput in logOutputs) {
      try {
        logOutput.output(event);
      } catch (e) {
        debugPrint('Log output failed');
      }
    }
  }
}

/// This is the simple logger that can be used to print logs.
/// It is a wrapper around the logger package.
/// it when instatiated, it requires you provide the name of the class.
Logger getLogger(
  String className, {
  bool printCallingFunctionName = true,
  bool printCallstack = true,
  List<String> exludeLogsFromClasses = const [],
  String? showOnlyClass,
}) {
  return Logger(
    printer: _SimpleLogPrinter(
      className,
      printCallingFunctionName: printCallingFunctionName,
      printCallStack: printCallstack,
      showOnlyClass: showOnlyClass,
      exludeLogsFromClasses: exludeLogsFromClasses,
    ),
    output: _MultipleLoggerOutput([
      if (!kReleaseMode) ConsoleOutput(),
    ]),
  );
}
