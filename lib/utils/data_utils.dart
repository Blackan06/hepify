// import 'dart:convert';

// import '../providers/thucan.dart';
// import 'package:http/http.dart' as http;

// class DataUtil {
//   Future<List<ThucAn>> getData() async {
//     List<ThucAn> listData = [];
//     try {
//       var request = http.Request(
//           'GET',
//           Uri.parse(
//               'https://shop-65063-default-rtdb.firebaseio.com/thucan.json'));

//       http.StreamedResponse response = await request.send();

//       if (response.statusCode == 200) {
//         var rawData = await response.stream.bytesToString();
//         List<dynamic> data = jsonDecode(rawData);
//         data.forEach((element) {
//           ThucAn model = ThucAn.fromJson(element);
//           listData.add(model);
//         });
//         return listData;
//       } else {
//         print(response.reasonPhrase);
//         return [];
//       }
//     } catch (e) {
//       print("Exception in Data $e");
//       throw e;
//     }
//   }
// }
