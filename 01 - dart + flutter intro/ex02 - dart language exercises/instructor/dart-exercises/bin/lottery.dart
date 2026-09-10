// inputs?  - two user inputs: number count <int>, upper limit (inclusive) <int>
// outputs? - a series of numbers to a terminal (List<int>, stdout/print)
//    ->
// 1. we're running this directly as a program, so i need a main()
// 2. I need to handle CLI user inputs & outputs, so i need the dart:io module
// 3. I need some sort of function that returns a List<int> (or similar series type) of numbers
// 4. Somehow, I need to make sure that doesn't have duplicates

import 'dart:io'; // 2.

void main() {     // 1.
  // print is equivalent to stdout.writeln and also doesn't require an import of dart:io
  print("Please enter how many lotto numbers are in the series.");
  int count = int.parse(stdin.readLineSync()!); // ! tells compiler, "trust me bro; this won't be null" — not best practice, but for brevity here

  print("What is the largest lotto number (inclusively)?");
  int largestNum = int.parse(stdin.readLineSync()!);
}