import 'package:flutter/material.dart';
import 'package:macro_counter/models/user_settings.dart';
import 'package:macro_counter/providers/user_settings_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _onSubmit(
    BuildContext context,
    UserSettings userSettings,
  ) async {
    final UserSettingsProvider provider =
        Provider.of<UserSettingsProvider>(context, listen: false);
    await provider.addObject(userSettings);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserSettingsProvider>(context);
    return FutureBuilder(
        future: provider.object,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final data = snapshot.data;
            double calorieGoal = data!.calorieGoal;
            double carbGoal = data.carbGoal;
            double proteinGoal = data.proteinGoal;
            double fatGoal = data.fatGoal;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.numberWithOptions(),
                          initialValue: calorieGoal.toString(),
                          decoration:
                              const InputDecoration(labelText: 'Calorie Goal'),
                          onChanged: (value) {
                            calorieGoal = double.parse(value);
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.numberWithOptions(),
                          initialValue: carbGoal.toString(),
                          decoration:
                              const InputDecoration(labelText: 'Carb Goal'),
                          onChanged: (value) {
                            carbGoal = double.parse(value);
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.numberWithOptions(),
                          initialValue: proteinGoal.toString(),
                          decoration:
                              const InputDecoration(labelText: 'Protein Goal'),
                          onChanged: (value) {
                            proteinGoal = double.parse(value);
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.numberWithOptions(),
                          initialValue: fatGoal.toString(),
                          decoration:
                              const InputDecoration(labelText: 'Fat Goal'),
                          onChanged: (value) {
                            fatGoal = double.parse(value);
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            UserSettings newSettings = UserSettings(
                              calorieGoal,
                              carbGoal,
                              proteinGoal,
                              fatGoal,
                            );
                            _onSubmit(context, newSettings).then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text("Saved!"),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            });
                          },
                          icon: const Icon(Icons.check),
                          label: const Text("Confirmar"),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Text("Something Went Wrong...");
          }
        });
  }
}

/**
 * 
 * 
 * Future<void> _onSubmit(UserSettingsProvider provider) async {
    UserSettings newSettings = UserSettings(
      double.parse(calorieGoal),
      double.parse(carbGoal),
      double.parse(proteinGoal),
      double.parse(fatGoal),
    );
    await provider.addObject(newSettings);
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<UserSettingsProvider>(context);
    settingsProvider.object.then((settings) {
      setState(() {
        calorieGoal = settings!.calorieGoal.toString();
        carbGoal = settings.carbGoal.toString();
        proteinGoal = settings.proteinGoal.toString();
        fatGoal = settings.fatGoal.toString();
      });
    });

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                TextFormField(
                  initialValue: calorieGoal,
                  decoration: const InputDecoration(labelText: 'Calorie Goal'),
                  onChanged: (value) {
                    setState(() {
                      calorieGoal = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  initialValue: carbGoal,
                  decoration: const InputDecoration(labelText: 'Carb Goal'),
                  onChanged: (value) {
                    setState(() {
                      carbGoal = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  initialValue: proteinGoal,
                  decoration: const InputDecoration(labelText: 'Protein Goal'),
                  onChanged: (value) {
                    setState(() {
                      proteinGoal = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  initialValue: fatGoal,
                  decoration: const InputDecoration(labelText: 'Fat Goal'),
                  onChanged: (value) {
                    setState(() {
                      fatGoal = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _onSubmit(settingsProvider).then(
                      (_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("Saved!"),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.check),
                  label: const Text("Confirmar"),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
 * 
 * 
 */
