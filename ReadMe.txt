Installation du pilote RNDIS signé
===================================

Ce dossier contient les fichiers nécessaires à l'installation d'un pilote USB RNDIS signé manuellement, ainsi que son certificat d'autorité. Ce pilote modifié est associé aux catégories de pilotes serial & networks. Il permet de forcer l'association de ce pilote avec l'équipement AS1620 (contrôleur de barrière BL229 d'Automatic Systems).

CONTENU DU DOSSIER
-------------------
- Install.cmd                 → Script d'installation automatique (à lancer en tant qu'administrateur)
- uninstall_signed_driver.cmd → Script de désinstallation automatique (à lancer en tant qu'administrateur)
- testcert.pfx                → Certificat PFX utilisé pour signer le pilote
- VST_RNDIS.inf               → Fichier INF du pilote RNDIS signé
- VST_RNDIS.cat               → Fichier catalogue généré
- ReadMe.txt                  → Ce fichier

PRÉREQUIS
----------
- Windows XP SP2 ou supérieur (x86 ou x64)
- Compte administrateur
- Connexion Internet NON requise
- Contrôle des comptes utilisateurs (UAC) peut afficher un avertissement

PROCÉDURE D'INSTALLATION
-------------------------
1. **Clique droit** sur `Install.cmd`
2. Choisis **"Exécuter en tant qu'administrateur"**
3. Laisse le script :
   - Importer le certificat PFX dans le magasin "Personnel"
   - Extraire la partie publique du certificat
   - Ajouter le certificat dans les "Autorités de certification racines de confiance"
   - Installer le pilote RNDIS pour le périphérique connecté
4. Une fois terminé, un message de succès s'affiche.
5. Le périphérique RNDIS doit être reconnu sans alerte de signature.

PROCÉDURE DE DÉSINSTALLATION
-----------------------------
1. **Clique droit** sur `Uninstall.cmd`
2. Choisis **"Exécuter en tant qu'administrateur"**
3. Le script va :
   - Supprimer le certificat du magasin "Personnel"
   - Supprimer le certificat du magasin des "Autorités de certification racines de confiance"
   - Désinstaller le pilote RNDIS installé
   - Nettoyer les fichiers temporaires (.cer)
4. Un message confirmera la fin de la désinstallation.

NOTES IMPORTANTES
------------------
- Si des erreurs apparaissent liées au certificat, assurez-vous :
  - Que la date/heure système est correcte
  - Que le fichier `.pfx` correspond bien au certificat utilisé pour signer le `.cat`
- Si un pilote existant est déjà installé, il peut être remplacé ou ignoré automatiquement.
- La désinstallation supprime toutes les occurrences du certificat nommé `TestRNDISCert` ainsi que tous les pilotes associés au fichier `VST_RNDIS.inf`.
- Il est recommandé de désinstaller ce pilote après usage pour des raisons de sécurité.

SUPPORT
--------
Il s'agit d'un pilote modifié, aucun support ne peut être délivré.

NB
---
Si après le branchement USB avec le contrôleur AS1620, le pilote utilisé est toujours un pilote de communication série, il faut mettre à jour le pilote et sélectionner parmi les pilotes suggérés celui qui vient d'être installé : Gestionnaire de périphériques > Sélectionner l'équipement série > cliquer droit et mettre à jour le pilote > Parcourir mon poste de travail pour rechercher des pilotes > Choisir parmi une liste de pilotes disponibles sur mon ordinateur > Sélectionner le pilote et suivant.