# MAYNZ — Menu numérique + panneau d'administration

Ce dossier contient un site statique bilingue et une interface d'administration connectée à Supabase.
Hébergement possible gratuitement sur GitHub Pages (dépôt public). La base utilise le plan gratuit Supabase.

## Mise en ligne — étapes

1. Créez un compte sur https://github.com et un dépôt public nommé `maynz-menu`.
2. Créez un compte sur https://supabase.com puis un projet (Free).
3. Dans Supabase, ouvrez **SQL Editor**, collez `supabase_setup.sql`, puis exécutez-le.
4. Dans Supabase > **Project Settings > API**, copiez Project URL et anon/public key.
5. Ouvrez `config.js` et remplacez les deux valeurs `VOTRE_...`. Ne mettez jamais la clé `service_role` dans le site.
6. Téléversez `index.html`, `config.js` et `supabase_setup.sql` dans le dépôt GitHub.
7. Dans GitHub > Settings > Pages, choisissez **Deploy from a branch**, branche `main`, dossier `/ (root)`, puis Save.
8. Après création du compte admin dans Supabase > Authentication > Users (Add user), copiez son UUID.
9. Dans Supabase SQL Editor, autorisez uniquement cet utilisateur en exécutant (remplacez UUID) :
   `insert into public.maynz_admins(user_id) values ('UUID-DU-COMPTE-ADMIN');`
10. Le menu public sera à `https://VOTRE-NOM.github.io/maynz-menu/`
    et l'administration à `https://VOTRE-NOM.github.io/maynz-menu/?admin=1`.

## Sécurité

- Le menu est lisible publiquement.
- Seuls les UUID présents dans `maynz_admins` peuvent modifier les prix.
- N'exposez jamais une clé `service_role`.
- Utilisez un mot de passe unique et activez la confirmation email si souhaité.
- Pour ajouter/supprimer des produits, il faudra adapter la table et l'interface; cette première version gère la modification des 13 prix.

## Limites du gratuit

Supabase Free peut mettre en pause un projet après une semaine d'inactivité. Il faudra parfois le réactiver depuis le tableau de bord. Les limites et conditions peuvent changer. GitHub Pages requiert un dépôt public avec GitHub Free.
