
import 'package:tasks_ia_koderx/src/shared/States/Visited_App/DatabaseVisited_helper.dart';
import 'package:tasks_ia_koderx/src/shared/States/Visited_App/interface/visited_table.dart';

class VisitedService{
  Future<List<VisitedTable>> getAllVisiteds(){
    return DatabaseVisitedHelper.instance.getData();
  }

  Future<int> saveLogged(String date){
    return DatabaseVisitedHelper.instance.insert(date);
  }
}