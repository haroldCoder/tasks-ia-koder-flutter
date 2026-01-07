import 'package:tasks_ia_koderx/src/domain/models/visited_table_model.dart';
import 'package:tasks_ia_koderx/src/shared/States/Visited_App/database_visited_helper.dart';

class VisitedService{
  Future<List<IVisitedTableModel>> getAllVisiteds(){
    return DatabaseVisitedHelper.instance.getData();
  }

  Future<int> saveLogged(String date){
    return DatabaseVisitedHelper.instance.insert(date);
  }
}