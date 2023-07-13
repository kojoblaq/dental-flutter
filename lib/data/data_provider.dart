import '../utils/network_utils.dart';
import 'models.dart';

Future<List<Doctor>> getDoctors(String? date) async {
  // UserData user = await readUser();

  final Map body = {'date': date};
  final result = await handleResponse(await getRequest('/api/dentists/'));
  final Iterable list = result;
  print(list);
  return list.map((model) => Doctor.fromJson(model)).toList();
}


// Future<Doctor> fetchDoctorData() async {
//   var http;
//   final response =
//       await http.get(Uri.parse('https://api.example.com/doctors/1'));

//   if (response.statusCode == 200) {
//     final Map<String, dynamic> responseData = json.decode(response.body);
//     return Doctor.fromMap(responseData);
//   } else {
//     throw Exception('Failed to fetch doctor data');
//   }
// }

