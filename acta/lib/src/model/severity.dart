enum Severity { info, warning, critical }
//{ debug, info, warning, error, fatal }

extension SeverityMapper on Severity {
  String toMap() {
    return toString().split('.').last;
  }

  static Severity fromMap(String value) {
    return Severity.values.firstWhere(
      (e) => e.toString().split('.').last == value,
    );
  }
}
