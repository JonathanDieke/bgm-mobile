import 'package:bgm/api/providers/user_provider.dart';
import 'package:bgm/components/button_widget.dart';
import 'package:bgm/components/my_dialog_box.dart';
import 'package:bgm/components/my_footer_component.dart';
import 'package:bgm/views/profile/components/dropdown_widget.dart';
import 'package:flutter/material.dart';

import '../../api/models/user_profile.dart';
import '../../utils/helpers.dart';
import 'components/profile_appbar.dart';
import 'components/profile_avatar.dart';
import 'components/textfield_widget.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late UserProfile userProfile;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    userProfile = UserProvider.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    double spaceYBetweenFields = 24;
    return Builder(
      builder: (context) => DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            physics: const BouncingScrollPhysics(),
            children: [
              const ProfileAvatar(
                imagePath:
                    'https://media.defense.gov/2020/Feb/19/2002251686/-1/-1/0/200219-A-QY194-002.JPG',
              ),
              /**
               * Année de naissance
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                label: 'Année de naissance (aaaa/mm/jj) :',
                text: userProfile.birthdate,
                onChanged: (birthdate) {
                  userProfile.birthdate = birthdate;
                },
              ),
              /**
               * Genre
               */
              SizedBox(height: spaceYBetweenFields),
              DropdownWidget(
                label: "Genre : ",
                initialValue: userProfile.gender,
                items: const [
                  DropdownMenuItem(value: "male", child: Text("Masculin")),
                  DropdownMenuItem(value: "female", child: Text("Féminin")),
                ],
                onChanged: (String? gender) {
                  userProfile.gender = gender ?? "";
                },
              ),
              /**
               * Groupe ethnique
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                label: 'Groupe ethnique : ',
                text: userProfile.ethnic,
                onChanged: (String ethnic) {
                  userProfile.ethnic = ethnic;
                },
              ),
              /**
               * Êtes vous alcoolique ?
               */
              SizedBox(height: spaceYBetweenFields),
              DropdownWidget(
                label: "Êtes-vous alcoolique ? ",
                initialValue: userProfile.isAlcoholic.toString(),
                items: const [
                  DropdownMenuItem(value: "false", child: Text("Non")),
                  DropdownMenuItem(value: "true", child: Text("Oui")),
                ],
                onChanged: (String? isAlcoholic) {
                  userProfile.isAlcoholic = isAlcoholic == "false" ? false : true;
                },
              ),
              /**
               * Êtes vous fumeur ?
               */
              SizedBox(height: spaceYBetweenFields),
              DropdownWidget(
                label: "Êtes-vous fumeur ? : ",
                initialValue: userProfile.isSmoker.toString(),
                items: const [
                  DropdownMenuItem(value: "false", child: Text("Non")),
                  DropdownMenuItem(value: "true", child: Text("Oui")),
                ],
                onChanged: (String? isSmoker) {
                  userProfile.isSmoker = isSmoker == "false" ? false : true;
                },
              ),
              /**
               * Poids
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                label: 'Poids (en Kg) : ',
                text: userProfile.weight.toString(),
                onChanged: (String weight) {
                  userProfile.weight = int.parse(weight);
                },
              ),
              /**
               * Taille
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                label: 'Votre taille (en cm) : ',
                text: userProfile.height.toString(),
                onChanged: (String height) {
                  userProfile.height = int.parse(height);
                },
              ),
              /**
               * Êtes-vous hyper-tendu ? 
               */
              SizedBox(height: spaceYBetweenFields),
              DropdownWidget(
                label: "Êtes-vous hypo/hyper-tendu(e) ? ",
                initialValue: userProfile.isTense.toString(),
                items: const [
                  DropdownMenuItem(value: "false", child: Text("Non")),
                  DropdownMenuItem(value: "true", child: Text("Oui")),
                ],
                onChanged: (String? isTense) {},
              ),
              /**
               * Êtes-vous hyper-tendu ? ?
               */
              SizedBox(height: spaceYBetweenFields),
              DropdownWidget(
                label: "Type de diabète : ",
                initialValue: userProfile.diabetesType.toString(),
                items: const [
                  DropdownMenuItem(value: "type1", child: Text("Type 1")),
                  DropdownMenuItem(value: "type2", child: Text("Type 2")),
                  DropdownMenuItem(value: "type3", child: Text("Type 3")),
                ],
                onChanged: (String? diabetesType) {
                  userProfile.diabetesType = diabetesType ?? "";
                },
              ),
              /**
               * Date de découverte
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                label: 'Date de découverte de la maladie (aaaa/mm/jj) : ',
                text: userProfile.discoverDate,
                onChanged: (String discoverDate) {
                  userProfile.discoverDate = discoverDate;
                },
              ),
              /**
               * Date de début de traitement
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                label: 'Date de début de traitement (aaaa/mm/jj) : ',
                text: userProfile.startTreatmentDate,
                onChanged: (String startTreatmentDate) {
                  userProfile.startTreatmentDate = startTreatmentDate;
                },
              ),
              /**
               * Type de traitement
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                label: 'Type de traitement : ',
                text: userProfile.treatmentType,
                onChanged: (String treatmentType) {
                  userProfile.treatmentType = treatmentType;
                },
              ),
              /**
               * Activité physique
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                label: 'Activité physique pratiquée : ',
                text: userProfile.physicActivities,
                onChanged: (String physicActivities) {
                  userProfile.physicActivities = physicActivities;
                },
              ),
              /**
               * Nombre de grossesses vécues
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                label: 'Nombre de grossesses vécues : ',
                text: userProfile.pregnancies.toString(),
                onChanged: (String pregancies) {
                  userProfile.pregnancies = int.parse(pregancies);
                },
              ),
              /**
               * Profession
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                label: 'Profession : ',
                text: userProfile.job,
                onChanged: (String job) {
                  userProfile.job = job;
                },
              ),
      
              /**
               * Bouton de soumission
               */
              SizedBox(height: spaceYBetweenFields),
              ButtonWidget(
                  isLoading: isLoading,
                  onPressed: () {
                    updateUserProfile();
                  }),
              SizedBox(height: spaceYBetweenFields),
              const MyFooterComponent()
            ],
          ),
        ),
      ),
    );
  }

  void updateUserProfile() {
    setState(() {
      isLoading = true;
    });

    UserProvider.setUserProfile(userProfile).then((data) {
      print('ok mise à jour du user profile réussie !!'.toUpperCase());

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
          );
        },
      );
    }).catchError((error, error2) {
      print(
          "Erreur mise à jour user profile :  ${error.toString()} --  \nerror2 : ${error2.toString()} ");

      setState(() {
        isLoading = false;
      });

      showSnackbar(context,
          "Quelque chose s'est mal passé : veuilez réessayer ! \nSi le problème persiste, contactez le service support",
          duration: 5000);
    });
  }

// fin - by Jonathan DIEKE
}
