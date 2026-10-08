import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

/* differences between stateful & stateless widgets:

    1. stateful widgets extend StatefulWidget (oo0o0o0o0o0o)

    2. override a createState() method that returns a State<T>, 
       not a build() that returns a widget tree

    3. think of the stateful widget itself as a wrapper/membrane around mutable state


*/
class MyHomePage extends StatefulWidget { // the widget itself is immutable, i.e. gets re-rendered (when state changes)
  const MyHomePage({super.key, required this.title});

  final String title; // this is not state! stateful data is contained in the State<T> for this widget (see next line of code)
                      // you can still pass initial values - like this title - that won't change across the widget's life cycle

  @override
  State<MyHomePage> createState() => _MyHomePageState(); // the state is mutable, and encapsulated in a separate class/instance
  /* in React, the 'actual state' is held in a Magic Place outside the functional component.
        useState    -> [x, setX]    but values held in a Magical Invisible Place

     in Flutter, that relationship is made explicit:
        createState -> State<T>()  
          
          where:
          - any instance attribute is automatically 'stateful'
          - each state instance relates to a specific widget (e.g. MyHomePage <---> State<MyHomePage>)
          - we don't have individual setters for individual attributes: 
            if I'm updating any stateful value, the entire component will re-render anyway

  */
}

// separate class/instance, subclass of State<T>, specific to its stateful widget
// this is *not* the widget itself; it's a compartmentalised place where stateful (mutable) data is held
// all the while, the stateful widget itself (MyHomePage) can remain immutable, and is re-rendered every time state changes
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // this is automatically stateful
                    // I could make more attributes here, and they'd be stateful too


  void _incrementCounter() {
    // note: callback functions in Dart are () {}, not () => {} as in JS
  
    setState(() { // I also only need one setter for *any* stateful attribute in here!
                  // this differs from React state because classes allow us to have 'one bag' where we put
                  // all the stateful data we need for a given component/widget
      _counter++;
    });
  }

  // what's this? the build() method lives inside the State<T> instance, *not* the StatefulWidget instance
  // this makes sense: we're building the element tree in the same scope/object/instance where the state is held,
  //                   because whatever's rendered depends on those stateful values
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
