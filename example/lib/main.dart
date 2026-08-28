import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

import 'design.dart';

void main() {
  initExampleScaleKit();
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleKitBuilder(
      designWidth: 375,
      designHeight: 812,
      designType: DeviceType.mobile,
      child: Builder(
        builder: (context) {
          return STThemeModeScope(
            builder: (context, mode) {
              return MaterialApp(
                title: 'Scale Theme Kit',
                theme: appST.light.copyWith(
                  textTheme: appST.light.createResponsiveTextTheme(
                    appST.light.textTheme,
                  ),
                ),
                darkTheme: appST.dark.copyWith(
                  textTheme: appST.dark.createResponsiveTextTheme(
                    appST.dark.textTheme,
                  ),
                ),
                themeMode: mode.mode,
                themeAnimationDuration: const Duration(milliseconds: 200),
                home: const GalleryPage(),
              );
            },
          );
        },
      ),
    );
  }
}

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  int _navIndex = 0;
  bool _switchValue = true;
  bool _checkValue = true;

  @override
  Widget build(BuildContext context) {
    final mode = context.stMode;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Look + size'),
        actions: [
          IconButton(
            tooltip: dark ? 'Switch to light' : 'Switch to dark',
            onPressed:
                () => mode.toggle(
                  platformBrightness: MediaQuery.platformBrightnessOf(context),
                ),
            icon: Icon(dark ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      drawer: const Drawer(
        child: SafeArea(child: ListTile(title: Text('Drawer'))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _navIndex,
        onDestinationSelected: (i) => setState(() => _navIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.palette), label: 'Look'),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Scale Kit sizes + Theme Kit look',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SKit.vSpaceSize(SKSize.sm),
          Text(
            'Material widgets below have no per-widget colors. '
            'SKCard inherits CardTheme. roundedContainerSize takes context.st.surface.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SKit.vSpaceSize(SKSize.md),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Appearance', style: context.st.label),
                  SKit.vSpaceSize(SKSize.sm),
                  SegmentedButton<ThemeMode>(
                    segments: const [
                      ButtonSegment(
                        value: ThemeMode.system,
                        label: Text('System'),
                        icon: Icon(Icons.brightness_auto),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        label: Text('Light'),
                        icon: Icon(Icons.light_mode),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        label: Text('Dark'),
                        icon: Icon(Icons.dark_mode),
                      ),
                    ],
                    selected: {mode.mode},
                    onSelectionChanged: (next) => mode.setMode(next.first),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Dark mode'),
                    subtitle: Text(
                      mode.mode == ThemeMode.system
                          ? 'Package switch: force light or dark.'
                          : (dark
                              ? 'Forced dark. Use System to follow the device.'
                              : 'Forced light. Use System to follow the device.'),
                    ),
                    trailing: const STThemeModeSwitch(),
                  ),
                ],
              ),
            ),
          ),
          SKit.vSpaceSize(SKSize.md),
          SKCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SKText(
                    'SKCard (theme fill)',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  SKit.vSpaceSize(SKSize.sm),
                  const ElevatedButton(
                    onPressed: _noop,
                    child: Text('ElevatedButton'),
                  ),
                ],
              ),
            ),
          ),
          SKit.vSpaceSize(SKSize.md),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Card (stock Flutter, no color:)'),
            ),
          ),
          SKit.vSpaceSize(SKSize.md),
          SKit.roundedContainerSize(
            all: SKSize.md,
            color: context.st.surface,
            borderColor: context.st.border,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SKit.roundedContainerSize',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'color: context.st.surface',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          SKit.vSpaceSize(SKSize.md),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              const ElevatedButton(onPressed: _noop, child: Text('Elevated')),
              const FilledButton(onPressed: _noop, child: Text('Filled')),
              const OutlinedButton(onPressed: _noop, child: Text('Outlined')),
              const TextButton(onPressed: _noop, child: Text('Text')),
            ],
          ),
          SKit.vSpaceSize(SKSize.sm),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                style: context.st.ghostButtonStyle,
                onPressed: _noop,
                child: const Text('Ghost'),
              ),
              ElevatedButton(
                style: context.st.destructiveButtonStyle,
                onPressed: _noop,
                child: const Text('Destructive'),
              ),
              ElevatedButton(
                style: context.st.ghostButtonStyle,
                onPressed: null,
                child: const Text('Ghost off'),
              ),
              ElevatedButton(
                style: context.st.destructiveButtonStyle,
                onPressed: null,
                child: const Text('Destructive off'),
              ),
              const ElevatedButton(
                onPressed: null,
                child: Text('Elevated off'),
              ),
            ],
          ),
          SKit.vSpaceSize(SKSize.sm),
          Text('Label', style: context.st.label),
          Text('Sublabel', style: context.st.sublabel),
          Text(
            'Description of this product from the design system.',
            style: context.st.description,
          ),
          Text('\$48', style: context.st.price),
          SKit.vSpaceSize(SKSize.md),
          DecoratedBox(
            decoration: context.st.productCardDecoration,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('product extra card'),
            ),
          ),
          SKit.vSpaceSize(SKSize.md),
          const TextField(
            decoration: InputDecoration(
              labelText: 'TextField',
              hintText: 'Inherited InputDecorationTheme',
            ),
          ),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('ListTile'),
            subtitle: Text('Inherited colors'),
          ),
          Row(
            children: [
              Switch(
                value: _switchValue,
                onChanged: (v) => setState(() => _switchValue = v),
              ),
              Checkbox(
                value: _checkValue,
                onChanged: (v) => setState(() => _checkValue = v ?? false),
              ),
              const Chip(label: Text('Chip')),
            ],
          ),
          const Divider(),
          const LinearProgressIndicator(),
          SKit.vSpaceSize(SKSize.sm),
          const SearchBar(hintText: 'SearchBar'),
          SKit.vSpaceSize(SKSize.sm),
          Slider(value: 0.4, onChanged: (_) {}),
          SKit.vSpaceSize(SKSize.sm),
          const Badge(label: Text('3'), child: Icon(Icons.notifications)),
          SKit.vSpaceSize(SKSize.sm),
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 0, label: Text('A')),
              ButtonSegment(value: 1, label: Text('B')),
            ],
            selected: const {0},
            onSelectionChanged: (_) {},
          ),
          SKit.vSpaceSize(SKSize.sm),
          Wrap(
            spacing: 8,
            children: [
              FilledButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Dialog'),
                        content: const Text('Surface from ThemeData'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Dialog'),
              ),
              FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('SnackBar from theme')),
                  );
                },
                child: const Text('SnackBar'),
              ),
            ],
          ),
          SKit.vSpaceSize(SKSize.md),
          SKit.roundedContainerSize(
            all: SKSize.md,
            color: context.st.highlightedContainerColor ?? context.st.surface,
            padding: const EdgeInsets.all(16),
            child: Text(
              'highlighted extra • brand ${context.st.brand}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

void _noop() {}
