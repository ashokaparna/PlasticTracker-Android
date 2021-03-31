import 'package:firebase_auth/firebase_auth.dart';
import 'package:plastic_tracker/api_client/client.dart';
import 'package:plastic_tracker/api_client/model/usage.dart';
import 'package:plastic_tracker/data/graph_input.dart';
import 'package:plastic_tracker/user/app_user.dart';

APIClient client = new APIClient(user);
final user = AppUser(uid: FirebaseAuth.instance.currentUser.uid);

Future<List<GraphInput>> getDailyGraphInput() async {
  Map<String, List<Usage>> dailyUsages = await client.getDailyUsages();
  List<GraphInput> lst = [];
  for(MapEntry<String, List<Usage>> entry in dailyUsages.entries){
    double totalWeight = 0;
    for (Usage usage in entry.value)
      totalWeight += usage.weight;
    lst.add(new GraphInput(date: entry.key, weight: totalWeight));
  }
  lst..sort((a,b) => compareDaily(a.date, b.date));
  return lst;
}

compareDaily(String a, String b){
  List<String> arr1 = a.split('_');
  List<String> arr2 = b.split('_');
  if(int.parse(arr1[0]) != int.parse(arr2[0]))
    return int.parse(arr1[0]).compareTo(int.parse(arr2[0]));
  else if(int.parse(arr2[1]) != int.parse(arr2[1]))
    return int.parse(arr1[1]).compareTo(int.parse(arr2[1]));
  return int.parse(arr1[2]).compareTo(int.parse(arr2[2]));
 }


Future<List<GraphInput>> getWeeklyGraphInput() async {
  Map<String, List<Usage>> weeklyUsages = await client.getWeeklyUsages();
  List<GraphInput> lst = [];
  for(MapEntry<String, List<Usage>> entry in weeklyUsages.entries){
    double totalWeight = 0;
    for(Usage usage in entry.value)
      totalWeight += usage.weight;
    lst.add(new GraphInput(date: entry.key, weight: totalWeight));
  }
  lst..sort((a,b) => compareWeekly(a.date, b.date));
  return lst;
}

compareWeekly(String a, String b) {
  List<String> arr1 = a.split('_');
  List<String> arr2 = b.split('_');
  if (int.parse(arr1[0]) != int.parse(arr2[0]))
    return int.parse(arr1[0]).compareTo(int.parse(arr2[0]));
  return int.parse(arr1[1]).compareTo(int.parse(arr2[1]));
}


Future<List<GraphInput>> getMonthlyGraphInput() async {
  Map<String, List<Usage>> monthlyUsages = await client.getMonthlyUsages();
  List<GraphInput> monthlyGraphData = [];
  for(MapEntry<String, List<Usage>> entry in monthlyUsages.entries){
    double totalWeight = 0;
    for(Usage usage in entry.value)
      totalWeight += usage.weight;
    monthlyGraphData.add(new GraphInput(date: entry.key, weight: totalWeight));
  }
  monthlyGraphData..sort((a,b) => compareMonthly(a.date, b.date));
  return monthlyGraphData;
}

compareMonthly(String a, String b) {
  List<String> arr1 = a.split('_');
  List<String> arr2 = b.split('_');
  if (int.parse(arr1[0]) != int.parse(arr2[0]))
    return int.parse(arr1[0]).compareTo(int.parse(arr2[0]));
  return int.parse(arr1[1]).compareTo(int.parse(arr2[1]));
}


