class IVisitedTableModel{
  late int id;
  late String datelog;

  IVisitedTableModel({required this.id, required this.datelog});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'datelog': datelog
    };
  }

  factory IVisitedTableModel.fromMap(Map<String, dynamic> map) {
    return IVisitedTableModel(
      id: map['id'],
      datelog: map['datelog']
    );
  }
}