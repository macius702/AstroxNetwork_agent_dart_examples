import 'dart:io';
import 'dart:convert';

void main() async {
  var filePath = '.dfx/playground/canister_ids.json';
  var file = File(filePath);

  if (await file.exists()) {
    var content = await file.readAsString();
    var jsonContent = jsonDecode(content);
    var backendCanisterId = jsonContent['counter']['playground'];
    var frontendCanisterId = jsonContent['frontend']['playground'];

    var url = 'https://$frontendCanisterId.icp0.io';

    var outputFile = File('lib/config.dart');
    await outputFile.writeAsString('''
const playground_frontend_url = '$url';
const playground_backendCanisterId = '$backendCanisterId';
    ''');

    print('File generated successfully.');
  } else {
    print('File does not exist.');
  }
}