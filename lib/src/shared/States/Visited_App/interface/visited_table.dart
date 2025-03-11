class VisitedTable{
  late int id;
  late String datelog;

  VisitedTable({required this.id, required this.datelog});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'datelog': datelog
    };
  }

  factory VisitedTable.fromMap(Map<String, dynamic> map) {
    return VisitedTable(
      id: map['id'],
      datelog: map['datelog']
    );
  }
}