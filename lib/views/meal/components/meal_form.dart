import 'package:bgm/components/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../api/providers/meal_provider.dart';
import '../../../components/my_dialog_box.dart';
import '../../../utils/constants.dart';
import '../../../utils/helpers.dart';

class MealForm extends StatefulWidget {
  const MealForm({Key? key}) : super(key: key);

  @override
  State<MealForm> createState() => _MealFormState();
}

class _MealFormState extends State<MealForm> {
  String? mealType, mealContent;
  int? mealHour, glycemiaBefore, glycemiaAfter;
  bool isLoading = false;

  TextEditingController glycemiaBeforeController = TextEditingController();
  TextEditingController glycemiaAfterController = TextEditingController();
  TextEditingController mealContentController = TextEditingController();

  List<DropdownMenuItem<String>> get mealTypeItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(value: "first_breakfast", child: Text("Petit-déjeuner")),
      DropdownMenuItem(value: "breakfast", child: Text("Déjeuner")),
      DropdownMenuItem(value: "dinner", child: Text("Dîner")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<int>> get mealHourItems {
    return [for (var i = 0; i < 24; i++) i]
        .map<DropdownMenuItem<int>>(
          (e) => DropdownMenuItem(
            value: e,
            child: Text("${e}h"),
          ),
        )
        .toList();
  }

  @override
  void dispose() {
    super.dispose();
    glycemiaBeforeController.dispose();
    glycemiaAfterController.dispose();
    mealContentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        // color: Colors.deepOrange,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          // vertical: 8.0,
          horizontal: 15,
        ),
        child: Form(
          child: Column(
            children: [
              //Titre du formulaire
              Container(
                alignment: Alignment.center,
                // margin: const EdgeInsets.only(top: 10),
                child: Text(
                  'Ajouter un repas'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    // color: Colors.black.withOpacity(0.7),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //Type de repas
              DropdownButtonFormField(
                hint: const Text('Type de repas'),
                isExpanded: true,
                elevation: 5,
                value: mealType,
                items: mealTypeItems,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: !isLoading
                    ? (String? newValue) {
                        setState(() {
                          mealType = newValue ?? "";
                        });
                      }
                    : null,
              ),
              const SizedBox(height: 20),
              //Heure du repas
              DropdownButtonFormField(
                hint: const Text('Heure du repas'),
                isExpanded: true,
                elevation: 5,
                value: mealHour,
                items: mealHourItems,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: !isLoading
                    ? (int? newValue) {
                        setState(() {
                          mealHour = newValue ?? 0;
                        });
                      }
                    : null,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      enabled: !isLoading,
                      controller: glycemiaBeforeController,
                      keyboardType:
                          const TextInputType.numberWithOptions(signed: false),
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Glycémie avant le repas (en mg/dL) ',
                        hintText: 'Example : 100',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          glycemiaBefore = int.parse(value);
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      enabled: !isLoading,
                      controller: glycemiaAfterController,
                      keyboardType:
                          const TextInputType.numberWithOptions(signed: false),
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Glycémie après le repas (en mg/dL) ',
                        hintText: 'Example : 100',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          glycemiaAfter = int.parse(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //Contenu du repas
              TextFormField(
                enabled: !isLoading,
                controller: mealContentController,
                maxLines: screenSize.width > 450 ? 4 : 6,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Contenu du repas',
                  hintText: 'Example : Haricot vert, poulet',
                  border: OutlineInputBorder(),
                ),
                onChanged: (String value) {
                  setState(() {
                    mealContent = value;
                  });
                },
              ),
              const SizedBox(height: 25),
              //Bouton de soumission
              ButtonWidget(
                isLoading: isLoading,
                onPressed: () {
                  savingMeal();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void savingMeal() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      isLoading = true;
    });

    MealProvider mealProvider =
        Provider.of<MealProvider>(context, listen: false);

    mealProvider.saveMeal({
      "type": mealType,
      "hour": mealHour,
      "content": mealContent,
      "glycemia_before": glycemiaBefore,
      "glycemia_after": glycemiaAfter
    }).then((Map<String, dynamic> data) {
      reinitializeForm();
      setState(() {
        isLoading = false;
      });

      //if bad token, redirect automatically on login view without come back possibility
      if (data['unauthorized']) {
        Navigator.pushReplacementNamed(context, "/login");
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title:
                data['result'] ? "Succès".toUpperCase() : "Echec".toUpperCase(),
            description: data['message'],
            footer: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
              ],
            ),
          );
        },
      );
    }).onError((error, stackTrace) {
      print(error.toString());
      reinitializeForm();

      setState(() {
        isLoading = false;
      });

      showSnackbar(context,
          "Quelque chose s'est mal passé : veuilez réessayer ! \nSi le problème persiste, contactez le service support",
          duration: Constants.durationShowSnackbar);
    });
  }

  reinitializeForm() {
    setState(() {
      mealType = null;
      mealHour = null;
      mealContent = null;
      glycemiaBefore = null;
      glycemiaAfter = null;
      glycemiaBeforeController.text = ' ';
      glycemiaAfterController.text = ' ';
      mealContentController.text = ' ';
    });
  }
//
}
