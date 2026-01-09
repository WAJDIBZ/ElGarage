<%@ page import="java.util.List, java.util.Map, java.util.stream.Collectors" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="doo.ClientDAO, doo.VoitureDAO" %>
<%@ page import="entity.Client, entity.Voiture" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String paramClient = request.getParameter("codeClient");
  // 1) Charger clients et véhicules
  ClientDAO clientDao   = new ClientDAO();
  VoitureDAO voitureDao = new VoitureDAO();
  List<Client>  clients  = clientDao.getAllClients();
  List<Voiture> voitures = voitureDao.getAllVoitures();
  Client selectedClient = null;
  if (paramClient != null) {
    selectedClient = clients.stream()
            .filter(c -> String.valueOf(c.getCodeClient()).equals(paramClient))
            .findFirst().orElse(null);
  }

  // 2) Construire les maps pour cascade et tarifs
  Map<String, List<String>> marqueMap = voitures.stream()
          .collect(Collectors.groupingBy(
                  Voiture::getMarque,
                  Collectors.mapping(Voiture::getModele, Collectors.toSet())
          )).entrySet().stream()
          .collect(Collectors.toMap(
                  Map.Entry::getKey,
                  e -> e.getValue().stream().sorted().collect(Collectors.toList())
          ));

  Map<String, List<String>> modeleMap = voitures.stream()
          .collect(Collectors.groupingBy(
                  Voiture::getModele,
                  Collectors.mapping(Voiture::getMatricule, Collectors.toList())
          ));

  Map<String, Double> tarifs = voitures.stream()
          .collect(Collectors.toMap(Voiture::getMatricule, Voiture::getTarif));
%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Créer un Contrat | ELGarage</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            primary: {
              50: '#f0f9ff',
              100: '#e0f2fe',
              200: '#bae6fd',
              300: '#7dd3fc',
              400: '#38bdf8',
              500: '#0ea5e9',
              600: '#0284c7',
              700: '#0369a1',
              800: '#075985',
              900: '#0c4a6e',
            }
          },
          boxShadow: {
            'card': '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
            'input': '0 1px 2px 0 rgba(0, 0, 0, 0.05)',
          },
        }
      }
    }
  </script>
</head>
<body class="bg-gradient-to-br from-gray-50 to-blue-50 min-h-screen flex items-center justify-center p-4 md:p-6 lg:p-8">
<div class="w-full max-w-3xl bg-white rounded-xl shadow-xl overflow-hidden">
  <!-- Header -->
  <div class="bg-primary-600 py-6 px-8">
    <h2 class="text-2xl font-bold text-white flex items-center">
      <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" viewBox="0 0 20 20" fill="currentColor">
        <path d="M8 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM15 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0z" />
        <path d="M3 4a1 1 0 00-1 1v10a1 1 0 001 1h1.05a2.5 2.5 0 014.9 0H11a1 1 0 001-1v-5h2v5a1 1 0 001 1h1.05a2.5 2.5 0 014.9 0H19a1 1 0 001-1v-4a3 3 0 00-.88-2.12L15.5 3.88A3 3 0 0013.38 3H9.1a3 3 0 00-2.12.88L4 6.88A3 3 0 003 9v1h-.5a1 1 0 100 2H3v2z" />
      </svg>
      Créer un Contrat de Location
    </h2>
    <p class="text-primary-100 text-sm">Complétez le formulaire pour enregistrer un nouveau contrat</p>
  </div>

  <!-- Form content -->
  <div class="p-8">
    <form id="formContrat" action="LocationServlet" method="post" class="space-y-6">
      <input type="hidden" name="action" value="ajouter"/>

      <!-- Sélection client -->
      <div class="bg-blue-50 p-4 rounded-lg">
        <label class="block text-sm font-medium text-gray-700 mb-1">Client</label>
        <select name="codeClient" id="select-client" required
                class="w-full border border-gray-300 px-3 py-2 rounded-lg shadow-input focus:outline-none focus:ring-2 focus:ring-primary-400 focus:border-primary-400 transition-all"
                <%= selectedClient != null ? "disabled" : "" %>>
          <option value="">-- Sélectionnez un client --</option>
          <% for (Client c : clients) { %>
          <option value="<%=c.getCodeClient()%>"
                  <%= selectedClient != null && c.getCodeClient() == selectedClient.getCodeClient()
                          ? "selected" : "" %>>
            <%=c.getNom()%> <%=c.getPrenom()%> (NCIN <%=c.getNcin()%>)
          </option>
          <% } %>
        </select>
        <% if (selectedClient != null) { %>
        <!-- Champ caché pour que servlet reçoive malgré le disabled -->
        <input type="hidden" name="codeClient" value="<%=selectedClient.getCodeClient()%>"/>
        <% } %>
      </div>

      <!-- Cascade Marque → Modèle → Disponible Matricule -->
      <div class="bg-gray-50 p-4 rounded-lg space-y-3">
        <h3 class="font-medium text-gray-800">Sélection du Véhicule</h3>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Marque</label>
            <select id="selMarque" class="w-full border border-gray-300 px-3 py-2 rounded-lg shadow-input focus:outline-none focus:ring-2 focus:ring-primary-400 focus:border-primary-400 transition-all">
              <option value="">-- Choisir une marque --</option>
              <% for(String m:marqueMap.keySet().stream().sorted().collect(Collectors.toList())) { %>
              <option><%=m%></option>
              <% } %>
            </select>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Modèle</label>
            <select id="selModele" class="w-full border border-gray-300 px-3 py-2 rounded-lg shadow-input focus:outline-none focus:ring-2 focus:ring-primary-400 focus:border-primary-400 transition-all" disabled>
              <option value="">-- Choisir un modèle --</option>
            </select>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Vehicules dispos</label>
            <button type="button" id="btnChercher" class="w-full bg-primary-600 hover:bg-primary-700 text-white py-2 px-4 rounded-lg shadow transition-colors flex items-center justify-center">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd" />
              </svg>
              Chercher disponibles
            </button>
          </div>
        </div>
      </div>

      <!-- Zone d'injection du select matricule -->
      <div id="voituresContainer" class="bg-blue-50 p-4 rounded-lg hidden">
        <!-- Content injected by JS -->
      </div>

      <!-- Dates -->
      <div class="bg-gray-50 p-4 rounded-lg space-y-3">
        <h3 class="font-medium text-gray-800">Période de Location</h3>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Date de début</label>
            <div class="relative">
              <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                </svg>
              </div>
              <input type="date" id="dateDebut" name="dateDebut" required
                     class="w-full border border-gray-300 pl-10 px-3 py-2 rounded-lg shadow-input focus:outline-none focus:ring-2 focus:ring-primary-400 focus:border-primary-400 transition-all"/>
            </div>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Date de fin</label>
            <div class="relative">
              <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                </svg>
              </div>
              <input type="date" id="dateFin" name="dateFin" required
                     class="w-full border border-gray-300 pl-10 px-3 py-2 rounded-lg shadow-input focus:outline-none focus:ring-2 focus:ring-primary-400 focus:border-primary-400 transition-all"/>
            </div>
          </div>
        </div>
      </div>

      <!-- Montant auto -->
      <div class="bg-blue-50 p-4 rounded-lg">
        <label class="block text-sm font-medium text-gray-700 mb-1">Montant total (DT)</label>
        <div class="relative">
          <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
          </div>
          <input type="text" id="montantAffiche" readonly
                 class="w-full border border-gray-300 pl-10 px-3 py-2 rounded-lg bg-gray-100 font-medium text-lg text-primary-700"/>
          <input type="hidden" id="montant" name="tarif"/>
        </div>
      </div>

      <!-- Statut -->
      <div class="bg-gray-50 p-4 rounded-lg">
        <label class="block text-sm font-medium text-gray-700 mb-1">Statut</label>
        <div class="relative">
          <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
          </div>
          <select name="statut" required
                  class="w-full border border-gray-300 pl-10 px-3 py-2 rounded-lg shadow-input focus:outline-none focus:ring-2 focus:ring-primary-400 focus:border-primary-400 transition-all">
            <option>En cours</option>
            <option>Confirmée</option>
            <option>Terminée</option>
          </select>
        </div>
      </div>

      <!-- Boutons -->
      <div class="flex justify-end pt-4 space-x-4 border-t border-gray-200">
        <a href="GererLocations.jsp"
           class="px-4 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors flex items-center">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M9.707 16.707a1 1 0 01-1.414 0l-6-6a1 1 0 010-1.414l6-6a1 1 0 011.414 1.414L5.414 9H17a1 1 0 110 2H5.414l4.293 4.293a1 1 0 010 1.414z" clip-rule="evenodd" />
          </svg>
          Annuler
        </a>
        <button type="submit"
                class="bg-primary-600 hover:bg-primary-700 text-white px-6 py-2 rounded-lg shadow transition-colors flex items-center">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
          </svg>
          Valider
        </button>
      </div>
    </form>
  </div>
</div>

<!-- Données JS -->
<script>
  const marqueMap  = <%= new com.google.gson.Gson().toJson(marqueMap) %>;
  const modeleMap  = <%= new com.google.gson.Gson().toJson(modeleMap) %>;
  const tarifs     = <%= new com.google.gson.Gson().toJson(tarifs) %>;
</script>

<script>
  document.addEventListener('DOMContentLoaded', ()=> {
    const selMarque    = document.getElementById('selMarque');
    const selModele    = document.getElementById('selModele');
    const btnChercher  = document.getElementById('btnChercher');
    const contVoitures = document.getElementById('voituresContainer');
    const dDebut       = document.getElementById('dateDebut');
    const dFin         = document.getElementById('dateFin');
    const outAff       = document.getElementById('montantAffiche');
    const outVal       = document.getElementById('montant');
    const today        = new Date().toISOString().split('T')[0];
    dDebut.min = today; dFin.min = today;

    // Marque → Modèles
    selMarque.addEventListener('change', ()=>{
      const m = selMarque.value;
      selModele.innerHTML = '<option value="">-- Choisir un modèle --</option>';
      if(m && marqueMap[m]) {
        marqueMap[m].forEach(md => {
          selModele.innerHTML += '<option>'+ md +'</option>';
        });
        selModele.disabled = false;
      } else {
        selModele.disabled = true;
      }
    });

    btnChercher.addEventListener('click', ()=>{
      const marque  = selMarque.value;
      const modele  = selModele.value;
      const debut   = dDebut.value;
      const fin     = dFin.value;
      if(!marque||!modele||!debut||!fin) {
        showToast('Veuillez remplir marque, modèle et dates.');
        return;
      }

      // Afficher indicateur de chargement
      btnChercher.innerHTML = '<svg class="animate-spin -ml-1 mr-2 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg> Recherche...';
      btnChercher.disabled = true;

      // Appel fragment corrigé
      fetch('AvailableVoitures?marque=' + encodeURIComponent(marque) + '&modele=' + encodeURIComponent(modele) + '&debut=' + debut + '&fin=' + fin)
              .then(r => r.text())
              .then(html => {
                // Restaurer bouton
                btnChercher.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd" /></svg> Chercher disponibles';
                btnChercher.disabled = false;

                // Modifier et montrer conteneur
                contVoitures.innerHTML = html;
                contVoitures.classList.remove('hidden');

                // Style supplémentaire pour l'élément injecté
                const selMat = document.querySelector('#voituresContainer select');
                if(selMat) {
                  selMat.classList.add('w-full', 'border', 'border-gray-300', 'px-3', 'py-2', 'rounded-lg', 'shadow-input', 'focus:outline-none', 'focus:ring-2', 'focus:ring-primary-400', 'focus:border-primary-400', 'transition-all');
                  selMat.addEventListener('change', calcMontant);
                }
                dDebut.addEventListener('change', calcMontant);
                dFin.addEventListener('change', calcMontant);
              });
    });

    // Calcul montant
    function calcMontant(){
      const selMat = document.querySelector('#voituresContainer select');
      const mat    = selMat?.value;
      if(!mat||!dDebut.value||!dFin.value) {
        outAff.value = ''; outVal.value = '';
        return;
      }
      const days = Math.max(1, Math.ceil((new Date(dFin.value)-new Date(dDebut.value))/(1000*60*60*24)));
      const montant = (days * (tarifs[mat]||0)).toFixed(2);
      outAff.value = montant+' DT';
      outVal.value = montant;
    }

    // Validation forme
    document.getElementById('formContrat').addEventListener('submit',e=>{
      const selMat = document.querySelector('#voituresContainer select');
      if(!selMat?.value||!dDebut.value||new Date(dFin.value)<new Date(dDebut.value)){
        e.preventDefault();
        showToast('Vérifiez véhicule et dates.');
      }
    });

    // Toast de notification
    function showToast(message) {
      // Créer élément toast
      const toast = document.createElement('div');
      toast.className = 'fixed top-4 right-4 bg-red-500 text-white px-6 py-3 rounded-lg shadow-lg flex items-center transform transition-all duration-500 translate-y-0 opacity-100';
      toast.innerHTML = `
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
        </svg>
        <span>${message}</span>
      `;
      document.body.appendChild(toast);

      // Supprimer après 3s
      setTimeout(() => {
        toast.classList.add('translate-y-4', 'opacity-0');
        setTimeout(() => toast.remove(), 500);
      }, 3000);
    }
  });
</script>
</body>
</html>