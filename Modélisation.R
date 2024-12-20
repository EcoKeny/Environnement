# Charger le fichier CSV
data <- read.csv("C:/Users/PC/Downloads/Occupancy.csv")

# afficher les premi�res lignes
head(data)

# v�rification des valeurs manquantes
sum(is.na(data))

# Importer le package 
library(ggplot2)

# Installer le package
install.packages("devtools")
library(devtools)

# Installer usethis
install.packages("usethis")

# Charger usethis
library(usethis)

# Charger ggplot2 pour faire la visualisation
library(ggplot2)
# Installer le package pour pouvoir faire la visualisation
installed.packages()
install.packages("ggplot2", repos = "https://cran.rstudio.com/")
find.package("ggplot2")
list.files("C:/Users/PC/AppData/Local/R/win-library/4.4")

# Visualisation des autres variables par rapport à la variable Occupancy
library(ggplot2)

# Obtenir un r�sum� rapide des colonnes
str(data)

# Afficher un r�sum� statistique de toutes les colonnes
summary(data)

# Afficher la dataframe
print(data)

dim(data)  # Retourne le nombre de lignes et de colonnes
nrow(data)  # Nombre de lignes
ncol(data)  # Nombre de colonnes

# Afficher les donn�es dans une interface graphique
View(data)

# Visualisation des relations avec la variable 'Occupancy'
library(ggplot2)
# Temprature vs Occupancy
library(ggplot2)

# Creation du graphique avec regression logistique
ggplot(data, aes(x = Temperature, y = Occupancy)) +
  geom_point() +  # Ajout des points de données
  geom_smooth(method = "glm", 
              method.args = list(family = binomial),  # Passer `family` via method.args
              se = FALSE, color = "blue") +  # Courbe de régression sans intervalle de confiance
  labs(title = "Régression Logistique : Température vs Occupation",
       x = "Température (°C)",
       y = "Occupation (0 = Non occupé, 1 = Occupé)")

# Humidity vs Occupancy
# Création du graphique avec régression logistique
ggplot(data, aes(x = Humidity, y = Occupancy)) +
  geom_point() +
  geom_smooth(method = "glm", 
              method.args = list(family = "binomial"), 
              se = FALSE, color = "blue") +
  labs(title = "Régression Logistique : Humidité vs Occupation",
       x = "Humidity (%)", 
       y = "Occupation (0 = Non occupé, 1 = Occupé)")
# CO2 vs Occupancy
# Creation du graphique avec regression logistique
ggplot(data, aes(x = CO2, y = Occupancy)) +
  geom_point() +  # Ajouter les points de données
  geom_smooth(method = "glm", 
              method.args = list(family = "binomial"),  # Spécifier `family` via method.args
              se = FALSE, color = "blue") +  # Courbe de régression sans intervalle de confiance
  labs(title = "Régression Logistique : CO2 vs Occupation",
       x = "CO2 (ppm)", 
       y = "Occupation (0 = Non occupé, 1 = Occupé)")

# Creation du modèle logistique pour prédire la probabilité d'occupation en fonction des autres variables

# Creer le modèle de regression logistique
model <- glm(Occupancy ~ Temperature + Humidity + Light + CO2 + HumidityRatio, 
             data = data_clean, 
             family = binomial)
# Suppression des lignes contenant des valeurs manquantes s'il y en a.
data_clean <- na.omit(data)

# Verifiez la structure de `data_clean`
str(data_clean)
# Suppression des lignes où certaines colonnes spécifiques qui ont des valeurs manquantes
data_clean <- data[complete.cases(data[, c("Temperature", "Humidity", "Light", "CO2", "HumidityRatio")]), ]

# Mod�le avec régression logistique
model <- glm(Occupancy ~ Temperature + Humidity + Light + CO2 + HumidityRatio, 
             data = data_clean, 
             family = binomial)

# Resume du modele
summary(model)

# Installer et charger glmnet pour mieux expliquer le modele de LASSO
install.packages("glmnet")
library(glmnet)

# Regression logistique avec regularisation L1 (lasso)
model_lasso <- glmnet(x = as.matrix(data_clean[, c("Temperature", "Humidity", "Light", "CO2", "HumidityRatio")]), 
                      y = data_clean$Occupancy, 
                      family = "binomial", alpha = 1)

# Resume du modele
summary(model_lasso)


# Supposons que vos donnees nettoyges sont dans 'data_clean'
# Si vous avez des valeurs manquantes, vous pouvez les supprimer comme suit
data_clean <- na.omit(data)

# Ajuster le modele de regression logistique avec Lasso
model_lasso <- glmnet(
  x = as.matrix(data_clean[, c("Temperature", "Humidity", "Light", "CO2", "HumidityRatio")]), 
  y = data_clean$Occupancy, 
  family = "binomial",  # Régression logistique (binomiale)
  alpha = 1  # alpha = 1 pour Lasso (régularisation L1)
)

# Resume du modele
print(model_lasso)

# Obtenir les coefficients du modèle
coef(model_lasso)

# Evaluation du modele
# Predictions sur les donnees
predictions <- predict(model, type = "response")

# Ajouter les predictions au jeu de donnees
data_clean$predicted_occupancy <- ifelse(predictions > 0.5, 1, 0)

# Visualiser les predictions
table(data_clean$Occupancy, data_clean$predicted_occupancy)

# Calcul de la precision, sensibilite et specificite
# Predictions sur les donnees
predictions <- predict(model, type = "response")

# Ameliorer le modele
# Installer et charger le package 'rpart' pour les arbres de décision
install.packages("rpart")
library(rpart)

# Creer un modele d'arbre de decision
tree_model <- rpart(Occupancy ~ Temperature + Humidity + Light + CO2 + HumidityRatio,
                    data = data_clean, method = "class")

# Resume de l'arbre de decision
summary(tree_model)



