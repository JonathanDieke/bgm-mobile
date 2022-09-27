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
          appBar: buildProfileAppBar(context),
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
                enabled: !isLoading,
                label: 'Année de naissance (aaaa/mm/jj) :',
                text: userProfile.birthdate,
                onChanged: (birthdate) {
                  setState(() {
                    userProfile.birthdate = birthdate;
                  });
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
                onChanged: !isLoading
                    ? (String? gender) {
                        setState(() {
                          userProfile.gender = gender ?? "";
                        });
                      }
                    : null,
              ),
              /**
               * Groupe ethnique
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                enabled: !isLoading,
                label: 'Groupe ethnique : ',
                text: userProfile.ethnic,
                onChanged: (String ethnic) {
                  setState(() {
                    userProfile.ethnic = ethnic;
                  });
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
                onChanged: !isLoading
                    ? (String? isAlcoholic) {
                        setState(() {
                          userProfile.isAlcoholic =
                              isAlcoholic == "false" ? false : true;
                        });
                      }
                    : null,
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
                onChanged: !isLoading
                    ? (String? isSmoker) {
                        setState(() {
                          userProfile.isSmoker =
                              isSmoker == "false" ? false : true;
                        });
                      }
                    : null,
              ),
              /**
               * Poids
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                enabled: !isLoading,
                label: 'Poids (en Kg) : ',
                text: userProfile.weight.toString(),
                onChanged: (String weight) {
                  setState(() {
                    userProfile.weight = int.parse(weight);
                  });
                },
              ),
              /**
               * Taille
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                enabled: !isLoading,
                label: 'Votre taille (en cm) : ',
                text: userProfile.height.toString(),
                onChanged: (String height) {
                  setState(() {
                    userProfile.height = int.parse(height);
                  });
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
                onChanged: !isLoading
                    ? (String? isTense) {
                        setState(() {
                          userProfile.isTense =
                              isTense == "false" ? false : true;
                        });
                      }
                    : null,
              ),
              /**
               * Type de diébète
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
                onChanged: !isLoading
                    ? (String? diabetesType) {
                        setState(() {
                          userProfile.diabetesType = diabetesType ?? "";
                        });
                      }
                    : null,
              ),
              /**
               * Date de découverte
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                enabled: !isLoading,
                label: 'Date de découverte de la maladie (aaaa/mm/jj) : ',
                text: userProfile.discoverDate,
                onChanged: (String discoverDate) {
                  setState(() {
                    userProfile.discoverDate = discoverDate;
                  });
                },
              ),
              /**
               * Date de début de traitement
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                enabled: !isLoading,
                label: 'Date de début de traitement (aaaa/mm/jj) : ',
                text: userProfile.startTreatmentDate,
                onChanged: (String startTreatmentDate) {
                  setState(() {
                    userProfile.startTreatmentDate = startTreatmentDate;
                  });
                },
              ),
              /**
               * Type de traitement
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                enabled: !isLoading,
                label: 'Type de traitement : ',
                text: userProfile.treatmentType,
                onChanged: (String treatmentType) {
                  setState(() {
                    userProfile.treatmentType = treatmentType;
                  });
                },
              ),
              /**
               * Activité physique
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                enabled: !isLoading,
                label: 'Activité physique pratiquée : ',
                text: userProfile.physicActivities,
                onChanged: (String physicActivities) {
                  setState(() {
                    userProfile.physicActivities = physicActivities;
                  });
                },
              ),
              /**
               * Nombre de grossesses vécues
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                enabled: !isLoading,
                label: 'Nombre de grossesses vécues : ',
                text: userProfile.pregnancies.toString(),
                onChanged: (String pregnancies) {
                  setState(() {
                    userProfile.pregnancies = int.parse(pregnancies);
                  });
                },
              ),
              /**
               * Profession
               */
              SizedBox(height: spaceYBetweenFields),
              TextFieldWidget(
                enabled: !isLoading,
                label: 'Profession : ',
                text: userProfile.job,
                onChanged: (String job) {
                  setState(() {
                    userProfile.job = job;
                  });
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
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      isLoading = true;
    });

    UserProvider.setUserProfile(userProfile).then((data) {
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
          "Erreur mise à jour user profile :  ${error.toString()} --  \nErreur 2 : ${error2.toString()} ");

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
