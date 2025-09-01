import 'package:flutter/material.dart';

import '../event.dart';
import '../loggers/console_logger.dart';

sealed class Strategy {
  void handle(Event event);
}

class ConsoleStrategy implements Strategy {
  final ConsoleLogger logger = ConsoleLogger();

  @override
  void handle(Event event) {
    logger.log(event);
  }
}

class GitHubIssueStrategy implements Strategy {
  final String repo;
  final String owner;
  final String token; // No real use secrets/environment

  final Severity minSeverity;

  GitHubIssueStrategy({
    required this.repo,
    required this.owner,
    required this.token,
    this.minSeverity = Severity.critical,
  });

  @override
  void handle(Event event) {
    if (event.severity.index < minSeverity.index) return;

    // Aqui só print por enquanto
    debugPrint('Criando issue no GitHub para evento: ${event.message}');

    // Depois podemos colocar a chamada real pra API do GitHub
    // Ex: POST https://api.github.com/repos/$owner/$repo/issues
  }
}
