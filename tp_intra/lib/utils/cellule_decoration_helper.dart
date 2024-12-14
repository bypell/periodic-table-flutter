import 'package:flutter/material.dart';
import 'package:tp_intra/models/element_data.dart';
import 'package:tp_intra/utils/constants.dart';

// retourne la bonne BoxDecoration pour une cellule d'élément
// recoit l'élément, si on veut une ombre, la règle de couleur et la valeur de la règle de couleur
BoxDecoration getElementBoxDecoration(
    {required ElementData element,
    bool avecOmbre = false,
    RegleDeCouleur regleDeCouleurs = RegleDeCouleur.element,
    num valeurRegleDeCouleurs = 0.0}) {
  Color? color;
  Gradient? gradient;

  switch (regleDeCouleurs) {
    case RegleDeCouleur.element:
      color = element.cpkHex.isNotEmpty
          ? Color(int.parse('FF${element.cpkHex}', radix: 16))
          : null;
      gradient = element.cpkHex.isEmpty
          ? const RadialGradient(
              colors: [Colors.red, Colors.blue],
            )
          : null;
      break;
    case RegleDeCouleur.ebulition:
      if (element.boil == valeurRegleDeCouleurs) {
        color = Colors.green;
      } else {
        color = element.boil > valeurRegleDeCouleurs ? Colors.red : Colors.blue;
      }
      break;
    case RegleDeCouleur.fusion:
      if (element.melt == valeurRegleDeCouleurs) {
        color = Colors.green;
      } else {
        color =
            element.melt > valeurRegleDeCouleurs ? Colors.blue : Colors.grey;
      }
      break;
  }

  return BoxDecoration(
    color: color,
    gradient: gradient,
    boxShadow: avecOmbre
        ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ]
        : null,
  );
}
