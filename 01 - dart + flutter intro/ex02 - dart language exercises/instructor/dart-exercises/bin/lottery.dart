// inputs?  - two user inputs: number count <int>, upper limit (inclusive) <int>
// outputs? - a series of numbers to a terminal (List<int>, stdout/print)
//    ->
// 1. we're running this directly as a program, so i need a main()
// 2. I need to handle CLI user inputs & outputs, so i need the dart:io module
// 3. I need some sort of function that returns a List<int> (or similar series type) of numbers
// 4. Somehow, I need to make sure that doesn't have duplicates


// Deduplication:
//  - Option A - keep a parallel array/list of numbers we've generated, check if already seen before putting in list
//  - Option B - check if value already in list ? decrement (i--) loop counter : add value to list
//  - Option C - instead of a list, use a set. loop until the set is {count} length

import 'dart:io'; // 2.
import 'dart:math';

void main() {     // 1.
  // print is equivalent to stdout.writeln and also doesn't require an import of dart:io
  print("Please enter how many lotto numbers are in the series.");
  int count = int.parse(stdin.readLineSync()!); // ! tells compiler, "trust me bro; this won't be null" — not best practice, but for brevity here

  print("What is the largest lotto number (inclusively)?");
  int largestNum = int.parse(stdin.readLineSync()!);

  // 3. number generation logic
  // https://api.dart.dev/dart-core/List/List.filled.html
  List<int> lottoNumbers = List.filled(count, 0); // not necessarily best option, just demoing language features
  Random    rng          = Random();

  for (int i = 0; i < count; i++) {
    // https://api.dart.dev/dart-math/Random-class.html 
    // Random.nextInt(upperLimit), 0 <= x < upperLimit,
    // so we add 1 to make it an inclusive range 
    int value = rng.nextInt(largestNum) + 1;

    // Option B. just check the list (lists are faster @ write, slower @ looking up, but this case is small)
    if (lottoNumbers.contains(value)) {
      i--; // pretend this iteration never happened
    } else {
      lottoNumbers[i] = value;
    }
  }

  print(lottoNumbers.join(' '));
}

