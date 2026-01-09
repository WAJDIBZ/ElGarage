# ElGarage

Application web Java (JSP/Servlets) de gestion de location de voitures : clients, véhicules, parcs, locations, calendrier et paiement.

> Repo GitHub attendu : **https://github.com/WAJDIBZ/ElGarage**

## Contenu du dépôt
Ce dépôt contient **2 variantes** du même projet (packaging `war`) :

- `gestion_location/` : version “classique” avec DAO/JDBC.
- `gestion_location_hebernate/` : version avec **Hibernate** (JPA).
- `gestion_location.sql` : script SQL (schema) pour la base `gestion_location`.

## Stack technique
- Java **21** (voir `maven-compiler-plugin`)
- Maven
- JSP / Jakarta Servlet **5.0**
- Tomcat **10.1.x** (Jakarta)
- MySQL / MariaDB
- Stripe (Checkout) pour paiement (optionnel)

## Pré-requis
- JDK 21
- Maven 3.9+
- Tomcat 10.1+
- MySQL/MariaDB en local

## Base de données
1. Crée la base (ou laisse MySQL la créer) : `gestion_location`
2. Importe le script :

```bash
mysql -u root -p gestion_location < gestion_location.sql
```

Notes :
- Les données “réelles” (emails/noms) ne doivent pas être publiées : le script du repo est prévu pour rester **sans données sensibles**.

## Configuration Stripe (optionnel)
Ce projet attend les clés via variables d’environnement (recommandé) :

- `STRIPE_SECRET_KEY` (serveur)
- `STRIPE_PUBLISHABLE_KEY` (front)

### Windows (PowerShell)
```powershell
setx STRIPE_SECRET_KEY "sk_test_xxx"
setx STRIPE_PUBLISHABLE_KEY "pk_test_xxx"
```
Redémarre ensuite Tomcat/IDE pour recharger les variables.

## Configuration Google OAuth (optionnel)
Pour activer l’inscription/connexion Google OAuth2 :

- `GOOGLE_OAUTH_CLIENT_ID`
- `GOOGLE_OAUTH_CLIENT_SECRET`

### Windows (PowerShell)
```powershell
setx GOOGLE_OAUTH_CLIENT_ID "xxx.apps.googleusercontent.com"
setx GOOGLE_OAUTH_CLIENT_SECRET "GOCSPX-xxx"
```

Si ces variables ne sont pas définies, le projet redirige vers `Inscription.jsp?error=google_oauth_not_configured`.

## Build (WAR)
### Variante JDBC
```bash
cd gestion_location
mvn clean package
```

### Variante Hibernate
```bash
cd gestion_location_hebernate
mvn clean package
```

Le fichier WAR sera dans `target/`.

## Déploiement sur Tomcat
Option simple :
1. Build le WAR (`mvn clean package`)
2. Copie le `.war` dans le dossier `webapps/` de Tomcat
3. Démarre Tomcat
4. Ouvre : `http://localhost:8080/gestion_location/`

## Dév rapide (conseils)
- Si tu utilises IntelliJ/Eclipse, configure un serveur Tomcat et déploie l’artefact `war`.
- Les identifiants DB sont actuellement en dur dans le code (ex: `root` / vide). Pour production, il faut externaliser.

## Sécurité / Secrets
- Ne commit **jamais** : clés Stripe, mots de passe, fichiers `target/`, `build/`, `classes/`.
- Le `.gitignore` à la racine est configuré pour ignorer ces dossiers.

## Auteur
- GitHub: **WAJDIBZ**

---
Si tu veux, je peux aussi :
- externaliser la config DB (URL/user/pass) via variables d’environnement,
- ajouter une petite section “Screenshots” si tu me fournis 2–3 captures.
