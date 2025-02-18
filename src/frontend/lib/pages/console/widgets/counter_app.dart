import 'package:flutter/material.dart';

enum CounterSegment {counter, history, schedule}
CounterSegment selected = CounterSegment.counter;
class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.secondary,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bancone",
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary
                      ),
                    ),
                    SegmentedButton<CounterSegment>(
                      segments: <ButtonSegment<CounterSegment>>[
                        ButtonSegment<CounterSegment>(
                          icon: Icon(Icons.countertops_outlined),
                          value: CounterSegment.counter,
                        ),
                        ButtonSegment<CounterSegment>(
                          icon: Icon(Icons.history),
                          value: CounterSegment.history,
                        ),
                        ButtonSegment<CounterSegment>(
                          icon: Icon(Icons.schedule),
                          value: CounterSegment.schedule,
                        ),
                      ],
                      selected: <CounterSegment>{selected},
                      onSelectionChanged: (Set<CounterSegment> value){
                        print(value);
                      },
                    ),
                  ],
                )
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: Placeholder(),
          )
        ],
      ),
    );
  }
}
