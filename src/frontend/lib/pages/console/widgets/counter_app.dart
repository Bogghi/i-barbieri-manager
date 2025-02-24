import 'package:flutter/material.dart';
import 'package:frontend/providers/console_provider.dart';
import 'package:provider/provider.dart';

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
                      showSelectedIcon: false,
                      style: SegmentedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.onSecondary,
                        foregroundColor: Theme.of(context).colorScheme.secondary,
                      ),
                      segments: const <ButtonSegment<CounterSegment>>[
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
                      selected: <CounterSegment>{context.watch<ConsoleProvider>().selected},
                      onSelectionChanged: (Set<CounterSegment> value){
                        context.read<ConsoleProvider>().setSelected(value.first);
                      },
                    ),
                  ],
                )
              ),
            ),
          ),
          const Expanded(
            flex: 15,
            child: Placeholder(),
          )
        ],
      ),
    );
  }
}
