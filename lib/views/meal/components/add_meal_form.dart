import 'package:flutter/material.dart';

class AddMealForm extends StatefulWidget {
  const AddMealForm({Key? key}) : super(key: key);

  @override
  State<AddMealForm> createState() => _AddMealFormState();
}

class _AddMealFormState extends State<AddMealForm> {
  final mealContent = TextEditingController();
  // String mealType = DateTime.now().hour < 12
  //     ? "first_breakfast"
  //     : (DateTime.now().hour > 17 ? "dinner" : "breakfast");
  String mealType = "";
  int mealHour = 0;
  bool isSaving = false;

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
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    print(screenSize.width);

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
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
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
                // value: mealType,
                items: mealTypeItems,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    mealType = newValue ?? "";
                  });
                },
              ),
              const SizedBox(height: 20),
              //Heure du repas
              DropdownButtonFormField(
                hint: const Text('Heure du repas'),
                isExpanded: true,
                elevation: 5,
                // value: mealHour,
                items: mealHourItems,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (int? newValue) {
                  setState(() {
                    mealHour = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: mealContent,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Glycémie avant le repas (en mg/dL) ',
                        hintText: 'Example : 100',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (text) {},
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: mealContent,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Glycémie après le repas (en mg/dL) ',
                        hintText: 'Example : 100',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (text) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //Contenu du repas
              TextField(
                maxLines: screenSize.width > 450 ? 4 : 6,
                controller: mealContent,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Contenu du repas',
                  hintText: 'Example : Haricot vert, poulet',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (text) {},
              ),
              const SizedBox(height: 25),
              //Bouton de soumission
              Container(
                constraints: BoxConstraints(
                  minWidth: screenSize.width,
                  minHeight: 50.0,
                ),
                decoration: const BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(10, 10),
                  ),
                ),
                child: !isSaving
                    // ignore: deprecated_member_use
                    ? RaisedButton(
                        onPressed: () {
                          savingMeal();
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(10, 10),
                          ),
                        ),
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.all(
                              Radius.elliptical(10, 10),
                            ),
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: screenSize.width,
                              minHeight: 50.0,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Enregistrer",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.deepOrange,
                          strokeWidth: 5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void savingMeal(){

  }

//
}
