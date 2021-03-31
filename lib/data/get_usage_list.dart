import 'package:firebase_auth/firebase_auth.dart';
import 'package:plastic_tracker/api_client/client.dart';
import 'package:plastic_tracker/api_client/model/usage.dart';
import 'package:plastic_tracker/user/app_user.dart';

APIClient client = new APIClient(user);
final user = AppUser(uid: FirebaseAuth.instance.currentUser.uid);

Future<Map<String,List<Usage>>> getUsageList() async {
  Map<String,List<Usage>> dailyUsageList = {};
  dailyUsageList = await client.getDailyUsages();
  for (String key in dailyUsageList.keys.toList()) {
    if(dailyUsageList[key].length == 0)
      dailyUsageList.remove(key);
  }
  return dailyUsageList;
}
