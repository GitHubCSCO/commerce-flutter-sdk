import 'dart:io';

String fixture(String fileName) =>
    File('test/fixtures/json/$fileName').readAsStringSync();
