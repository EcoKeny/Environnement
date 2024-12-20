# Analyse des Données sur l'Occupation d'une Pièce en Fonction des Paramètres Environnementaux

## Introduction

Cette étude vise à analyser les facteurs environnementaux influençant l'occupation d'une pièce. Les variables considérées sont :
- **Température (°C)**
- **Humidité (%)**
- **Lumière (Lux)**
- **CO2 (ppm)**
- **Ratio d'humidité**
- **Occupation (variable cible binaire : 0 = non occupée, 1 = occupée)**

## Objectifs

- Identifier les variables clés permettant de prédire l'occupation d'une pièce.
- Proposer un modèle simple et interprétable pour cette prédiction.

## Description des Données

Les données comprennent **20 560 observations** et 7 variables. Voici un résumé statistique des principales variables :

| Variable           | Moyenne  | Min   | 1er Quartile | Médiane | 3e Quartile | Max    |
|--------------------|----------|-------|--------------|---------|-------------|--------|
| Température (°C)   | 20.91    | 19.00 | 20.20        | 20.70   | 21.52       | 24.41  |
| Humidité (%)       | 27.66    | 16.75 | 24.50        | 27.29   | 31.29       | 39.50  |
| Lumière (Lux)      | 130.8    | 0.0   | 0.0          | 0.0     | 301.0       | 1697.2 |
| CO2 (ppm)          | 690.6    | 412.8 | 460.0        | 565.4   | 804.7       | 2076.5 |
| Ratio d'Humidité   | 0.0042   | 0.0027| 0.0037       | 0.0042  | 0.0048      | 0.0064 |
| Occupation (%)     | 0.231    | 0     | 0            | 0       | 0           | 1      |

**Observation :** Seulement 23,1 % des données indiquent une pièce occupée.

## Méthodes Utilisées

1. **Régression LASSO** :
   - Identifier les variables influentes.
   - Résultats :
     - **Lumière** : Principal prédicteur.
     - **CO2** : Facteur secondaire.
     - **Température** : Impact marginal.
   - **Précision globale** : 90,19 %.

2. **Arbre de Décision** :
   - Règles principales :
     - Si **lumière < 388.17**, alors la pièce est probablement non occupée.
     - Sinon, vérifiez la température (< 21.21 °C) ou le CO2 (< 771.17 ppm).
   - Importance des variables :
     - Lumière (55 %)
     - Température (22 %)
     - CO2 (19 %)

## Résultats Clés

- La lumière est le facteur déterminant dans la prédiction de l'occupation.
- Les modèles LASSO et Arbre de décision affichent une précision supérieure à 90 %.
- Une faible lumière et un faible CO2 suggèrent une pièce non occupée.

## Recommandations

- **Surveillance automatisée** : Utiliser des capteurs de lumière et de CO2 pour prédire l'occupation.
- **Optimisation énergétique** : Ajuster les systèmes d’éclairage et de ventilation en fonction des prédictions.

Source de données:https://www.kaggle.com/datasets/kukuroo3/room-occupancy-detection-data-iot-sensor
