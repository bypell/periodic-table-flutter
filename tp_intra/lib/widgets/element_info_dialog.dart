import 'package:flutter/material.dart';
import 'package:tp_intra/models/element_data.dart';
import 'package:tp_intra/utils/cellule_decoration_helper.dart';
import 'package:tp_intra/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ElementInfoDialog extends StatelessWidget {
  final ElementData element;
  final RegleDeCouleur regleDeCouleurs;
  final num valeurRegleDeCouleurs;
  const ElementInfoDialog(
      {super.key,
      required this.element,
      required this.regleDeCouleurs,
      required this.valeurRegleDeCouleurs});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(alignment: AlignmentDirectional.topCenter, children: [
        // un container avec un background gris qui contient les informations de l'élément (ScrollableElementInfo)
        Container(
          margin: const EdgeInsets.only(top: 50),
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 56, 56, 56),
                Color.fromARGB(255, 36, 36, 36)
              ],
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 20, right: 30),
              child: ScrollableElementInfo(element: element)),
        ),
        // Boite de l'élément avec symbole
        Positioned(
          top: 0,
          child: Container(
            height: 100,
            width: 100,
            decoration: getElementBoxDecoration(
                element: element,
                avecOmbre: true,
                regleDeCouleurs: regleDeCouleurs,
                valeurRegleDeCouleurs: valeurRegleDeCouleurs),
            child: Center(
              child: Text(
                element.symbol,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class ScrollableElementInfo extends StatelessWidget {
  final ElementData element;
  const ScrollableElementInfo({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView(children: [
        Center(
          child: Text(
            element.name,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //nombre et masse atomique
        ParagrapheInfo(
            texte:
                'Numéro atomique: ${element.number} \nMasse atomique: ${element.atomicMass}'),
        // point débullition et fusion
        ParagrapheInfo(
            texte:
                'Point de fusion: ${element.melt} K \nPoint d\'ébullition: ${element.boil} K'),
        // catégorie
        ParagrapheInfo(texte: 'Catégorie: ${element.category}'),
        // type
        ParagrapheInfo(texte: 'Type de phase: ${element.phase}'),
        // decouvert pas
        ParagrapheInfo(texte: 'Découvert par: ${element.discoveredBy}'),
        // desc
        ParagrapheInfo(texte: 'Description: ${element.summary}'),
        //source clickable
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: InkWell(
            onTap: () async {
              final Uri lien = Uri.parse(element.source);
              if (await canLaunchUrl(lien)) {
                await launchUrl(lien);
              } else {
                print('pas réussi à ouvrir le lien');
              }
            },
            child: const Text(
              'Source',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class ParagrapheInfo extends StatelessWidget {
  final String texte;
  const ParagrapheInfo({super.key, required this.texte});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Text(
        texte,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
