import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/utils/api_provider.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class TaskRepository {
  static final TaskRepository _singleton = TaskRepository._();

  static TaskRepository get instance => _singleton;

  TaskRepository._();

  ///
  /// Query Zeiss lens inventory data with ownerName and skuCode
  ///
  Future<http.Response> queryInventoryData(String brand, String skuCode) async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final header = {'Content-Type': 'application/json; charset=UTF-8'};
    final body = {
      "code": 0,
      "success": true,
      "result": [
        {
          "skuCode": skuCode,
          "brand": brand,
          "model": "Zeiss-2023",
          "lensType": "lens001",
          "stockQuantity": 3000
        },
        {
          "skuCode": skuCode,
          "brand": brand,
          "model": "Zeiss-2023",
          "lensType": "lens002",
          "stockQuantity": 200
        },
        {
          "skuCode": skuCode,
          "brand": brand,
          "model": "Zeiss-2023",
          "lensType": "lens003",
          "stockQuantity": 100
        },
      ]
    };
    final response = await http
        .post(uri, body: json.encode(body), headers: header)
        .timeout(const Duration(seconds: 30));
    return response;
  }

  ///
  /// Query attendance data
  ///
  Future<http.Response> queryAttendanceData(String date, String depart) async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final header = {'Content-Type': 'application/json; charset=UTF-8'};
    final body = {
      "code": 0,
      "success": true,
      "result": {
        "depart": depart,
        "dateStart": date,
        "dateEnd": date,
        "lateArrival": 30,
        "earlyDeparture": 3,
        "absenteeism": 1,
        "leave": 2,
        "businessTrips": 10
      }
    };
    final response = await http
        .post(uri, body: json.encode(body), headers: header)
        .timeout(const Duration(seconds: 30));
    debugPrint(response.body);
    return response;
  }

  ///
  /// Submit leave data
  ///
  Future<http.Response> submitLeaveData(String dateStart, String timeStart,
      String dateEnd, String timeEnd, String leaveReason) async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final header = {'Content-Type': 'application/json; charset=UTF-8'};
    final body = {
      'code': 0,
      'success': true,
      'result': {
        "dateStart": dateStart,
        "timeStart": timeStart,
        "dateEnd": dateEnd,
        "timeEnd": timeEnd,
        "leaveReason": leaveReason,
        "leaveStatus": "Leave submitted successfully"
      }
    };
    final response = await http
        .post(uri, body: json.encode(body), headers: header)
        .timeout(const Duration(seconds: 30));
    return response;
  }

  ///
  /// Functions Call
  ///
  List<String> functionCall = [
    'queryAttendanceData',
    'queryInventoryData',
    'submitLeaveData'
  ];

  ///
  /// Functions info
  ///
  List<Map<String, dynamic>> functionInfo() {
    return [
      {
        "name": "queryAttendanceData",
        "description":
            "Query departmental attendance data for the current time",
        "parameters": {
          "type": "object",
          "properties": {
            "attendance_date": {
              "type": "string",
              "description":
                  "Attendance dates, such as：2023-07-17，2023-07-16，2023-07-15，2023-07-14，format is{yyyy-MM-dd}"
            },
            "attendance_depart": {
              "type": "string",
              "description":
                  "Attendance departments,such as：研发部(R&D),市场部(Marketing),人力资源(HR)"
            }
          },
          "required": ["attendance_date", 'attendance_depart']
        }
      },
      {
        "name": "queryInventoryData",
        "description": "Query Zeiss lens inventory data",
        "parameters": {
          "type": "object",
          "properties": {
            "brand": {
              "type": "string",
              "description":
                  "Brand name,such as：Zeiss，Essilor，format is{brand：}"
            },
            "sku_code": {
              "type": "string",
              "description":
                  "Sku code,such as：78969993499538304,format is{skuCode：}"
            }
          },
          "required": ["brand"]
        }
      },
      {
        "name": "submitLeaveData",
        "description":
            "Submission of leave requests based on the given date-time-reason",
        "parameters": {
          "type": "object",
          "properties": {
            "date_start": {
              "type": "string",
              "description":
                  "Leave start date,such as：2023-07-18，2023-07-17，2023-07-16，format is{yyyy-MM-dd}"
            },
            "time_start": {
              "type": "string",
              "description":
                  "Leave start time,such as：09:00,10:00,11:00,format is{HH:mm}"
            },
            "date_end": {
              "type": "string",
              "description":
                  "Leave end date,such as：2023-07-18，2023-07-17，2023-07-16，format is{yyyy-MM-dd}"
            },
            "time_end": {
              "type": "string",
              "description":
                  "Leave end time,such as：16:00,17:00,18:00,format is{HH:mm}"
            },
            "leave_reason": {
              "type": "string",
              "description":
                  "Leave reason,such as：Unable to go to work normally due to hot weather，Need to go to the hospital if you are not feeling well，Children are sick and need to be taken care of"
            },
          },
          "required": [
            "date_start",
            "time_start",
            "date_end",
            "time_end",
            "leave_reason"
          ]
        }
      },
    ];
  }

  ///
  /// 直接请求ChatGPT API
  /// [Request stream message with openai api]
  ///
  Future<Stream<String>> sendMessageStreamTask(String inputStr) async {
    var url = Uri.https('api.openai.com', 'v1/chat/completions');
    final headers = {
      'Authorization': 'Bearer ${ApiProvider.aiApiKey}',
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final params = {
      "model": ApiProvider.aiModel,
      "temperature": 0,
      "messages": [
        {"role": "user", "content": inputStr}
      ],
      "functions": functionInfo(),
      "function_call": "auto",
    };
    final body = jsonEncode(params);
    try {
      final response = await http
          .post(url, body: body, headers: headers)
          .timeout(const Duration(seconds: 60));
      final taskJson = jsonDecode(utf8.decode(response.bodyBytes));
      final message = taskJson['choices'][0]['message'];

      ///if param [function_call] is null,it means do not process next task
      if (message['function_call'] == null) {
        return Stream<String>.value('\nerror: ${message['content']}');
      }
      final functionName = message['function_call']['name'];
      final functionArgs = jsonDecode(message['function_call']['arguments']);

      ///check function
      if (!functionCall.contains(functionName)) {
        return errorStream();
      }
      final String contentData;

      ///match function : queryAttendanceData
      if (functionName == functionCall[0]) {
        final attendanceData = await queryAttendanceData(
            functionArgs['attendance_date'], functionArgs['attendance_depart']);
        final jsonData = jsonDecode(attendanceData.body);
        if (jsonData['code'] != 0) {
          return errorStream();
        }
        contentData = jsonEncode(jsonData['result']);
      }

      ///match function : queryInventoryData
      else if (functionName == functionCall[1]) {
        final inventoryData = await queryInventoryData(
            functionArgs['brand'], functionArgs['sku_code']);
        final jsonData = jsonDecode(inventoryData.body);
        if (jsonData['code'] != 0) return errorStream();
        contentData = jsonEncode(jsonData['result']);
      }

      ///match function : submitLeaveData
      else {
        final leaveData = await submitLeaveData(
            functionArgs['date_start'],
            functionArgs['time_start'],
            functionArgs['date_end'],
            functionArgs['time_end'],
            functionArgs['leave_reason']);
        final jsonData = jsonDecode(leaveData.body);
        if (jsonData['code'] != 0) return errorStream();
        contentData = jsonEncode(jsonData);
      }

      /// merge functions info and contentData
      final dataParams = {
        "model": ApiProvider.aiModel,
        "temperature": 0,
        "stream": true,
        "messages": [
          {"role": "user", "content": inputStr},
          message,
          {"role": "function", "name": functionName, "content": contentData}
        ],
        "functions": functionInfo(),
        "function_call": "auto",
      };
      final dataRequest = http.Request('POST', url);
      dataRequest.headers.addAll(headers);
      dataRequest.body = jsonEncode(dataParams);
      final dataResponse = await http.Client()
          .send(dataRequest)
          .timeout(const Duration(seconds: 60));
      return dataResponse.stream.transform(utf8.decoder);
    } catch (e) {
      Logger().d('${t.app.error} : $e');
      return errorStream();
    }
  }

  ///
  /// Python API
  ///
  Future<Stream<String>> sendMessageStreamApi(String message) async {
    var uri = Uri.parse('http://127.0.0.1:8000/api/llm/v1/task');
    var request = http.Request('POST', uri);
    request.headers.addAll({'Content-Type': 'application/json; charset=UTF-8'});
    request.body = jsonEncode({"question": message});
    final response =
        await http.Client().send(request).timeout(const Duration(seconds: 120));
    final stream =
        response.stream.transform(utf8.decoder).transform(const LineSplitter());
    return stream;
  }

  ///
  /// Test stream returning
  ///
  Future<Stream<String>> getDataStream(
      Function waiting, Function finish) async {
    var url = Uri.https('api.catboys.com', 'img');
    var request = http.Request('GET', url);
    final response =
        await http.Client().send(request).timeout(const Duration(seconds: 45));
    return response.stream.transform(utf8.decoder);
  }

  ///
  /// Error Stream
  ///
  Stream<String> errorStream() {
    return Stream<String>.value(
        '\nerror: Sorry，AI-Assistant does not know the answer to this question yet');
  }
}
