import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const InterestPicker(),
    );
  }
}

// Real-world scenario: an onboarding screen where a user picks interests.
class InterestPicker extends StatefulWidget {
  const InterestPicker({super.key});

  @override
  State<InterestPicker> createState() => _InterestPickerState();
}

class _InterestPickerState extends State<InterestPicker> {
  final List<String> interests = [
    'Music', 'Football', 'Cooking', 'Travel', 'Gaming', 'Photography',
    'Reading', 'Fashion', 'Movies', 'Coding', 'Fitness', 'Art',
  ];
  final Set<String> selected = {};

  // The three Wrap properties we change live.
  // The starting values are Flutter's defaults.
  double spacing = 0; // gap between chips on the same line
  double runSpacing = 0; // gap between lines
  WrapAlignment alignment = WrapAlignment.start; // how each line is placed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick your interests')),
      // ListView scrolls, so nothing overflows on a short phone screen
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
            // THE WIDGET WE ARE PRESENTING
            Wrap(
              spacing: spacing,
              runSpacing: runSpacing,
              alignment: alignment,
              children: [
                for (final interest in interests)
                  FilterChip(
                    label: Text(interest),
                    selected: selected.contains(interest),
                    // shrinkWrap removes extra tap padding so the gaps
                    // we control are the only gaps on screen
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onSelected: (isOn) => setState(() {
                      isOn ? selected.add(interest) : selected.remove(interest);
                    }),
                  ),
              ],
            ),
            const Divider(height: 32),

            // Controls to change the three properties live
            Text('spacing: ${spacing.round()}'),
            Slider(
              value: spacing,
              max: 40,
              onChanged: (v) => setState(() => spacing = v),
            ),
            Text('runSpacing: ${runSpacing.round()}'),
            Slider(
              value: runSpacing,
              max: 40,
              onChanged: (v) => setState(() => runSpacing = v),
            ),
            DropdownButton<WrapAlignment>(
              value: alignment,
              items: [
                WrapAlignment.start,
                WrapAlignment.center,
                WrapAlignment.end,
                WrapAlignment.spaceBetween,
              ]
                  .map((a) => DropdownMenuItem(
                        value: a,
                        child: Text('alignment: ${a.name}'),
                      ))
                  .toList(),
              onChanged: (a) => setState(() => alignment = a!),
            ),
        ],
      ),
    );
  }
}