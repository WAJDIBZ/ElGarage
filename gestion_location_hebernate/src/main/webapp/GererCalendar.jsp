<%@ page import="java.util.List" %>
<%@ page import="doo.LocationDAO" %>
<%@ page import="entity.Location" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gérer les Locations | ELGarage</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet"/>

    <style>
        #calendar {
            max-width: 900px;
            margin: 40px auto;
            background: #fff;
            border-radius: 6px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.15);
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: {
                            50:  '#f0f9ff',
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
                    }
                }
            }
        }
    </script>
    <style>
        thead th { position: sticky; top: 0; z-index: 10; background: white; }
    </style>
</head>
<body class="bg-gray-50 min-h-screen font-sans">
<div class="flex">
    <!-- Sidebar -->
    <div class="fixed h-screen w-64 bg-primary-800 text-white shadow-xl">
        <div class="p-6 border-b border-primary-700">
            <h2 class="text-2xl font-bold">ELGarage</h2>
            <p class="text-xs text-primary-300">Location de voitures</p>
        </div>
        <nav class="mt-6">
            <a href="GererClient.jsp" class="flex items-center py-3 pl-6 pr-4 hover:bg-primary-700 transition">
                <i class="fas fa-users mr-3"></i><span>Clients</span>
            </a>
            <a href="GererVehicules.jsp" class="flex items-center py-3 pl-6 pr-4 hover:bg-primary-700 transition">
                <i class="fas fa-car mr-3"></i><span>Véhicules</span>
            </a>
            <a href="GererLocations.jsp" class="flex items-center py-3 pl-6 pr-4 hover:bg-primary-700 transition">
                <i class="fas fa-calendar-check mr-3"></i><span>Locations</span>
            </a>
            <a href="GererCalendar.jsp" class="flex items-center py-3 pl-6 pr-4 bg-primary-700 border-l-4 border-white">
                <i class="fas fa-calendar-check mr-3"></i><span>Calendrier</span>
            </a>
            <a href="GererParcs.jsp" class="flex items-center py-3 pl-6 pr-4 hover:bg-primary-700 transition">
                <i class="fas fa-parking mr-3"></i><span>Parcs</span>

            </a>


        </nav>
        <div class="absolute bottom-0 w-full p-4 border-t border-primary-700">
            <div class="flex items-center">
                <div class="h-10 w-10 rounded-full bg-primary-600 flex items-center justify-center">
                    <i class="fas fa-user"></i>
                </div>
                <div class="ml-3">
                    <p class="font-medium">Admin</p>
                    <p class="text-xs text-primary-300">admin@elgarage.com</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Main -->
    <div class="ml-64 w-full">
        <!-- Top bar -->
        <div class="bg-white shadow-md p-4 flex justify-between items-center">
            <div class="flex items-center">
                <button class="mr-4 text-gray-500 hover:text-primary-500"><i class="fas fa-bars text-xl"></i></button>
                <h1 class="text-xl font-semibold text-gray-700">Tableau de bord</h1>
            </div>
            <a href="index.jsp" class="flex items-center text-red-700 hover:text-red-800">
                <i class="fas fa-sign-out-alt mr-2"></i>Déconnexion
            </a>
        </div>

        <!-- Content -->
        <!-- Content -->
        <div class="bg-gradient-to-br from-gray-50 to-blue-50 p-6 min-h-screen">
            <div class="mb-6">
                <div class="flex justify-between items-center">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-800">Calendrier des Locations</h1>
                        <p class="text-gray-600 mt-1">Visualisez et gérez votre planning de réservations</p>
                    </div>
                    <div class="flex space-x-2">
                        <a href="AjouterLocation.jsp" class="flex items-center px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors shadow-md">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z" clip-rule="evenodd" />
                            </svg>
                            Nouvelle Location
                        </a>
                        <button type="button" id="btn-refresh" class="flex items-center px-4 py-2 bg-white text-primary-600 border border-primary-300 rounded-lg hover:bg-gray-50 transition-colors shadow-sm">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M4 2a1 1 0 011 1v2.101a7.002 7.002 0 0111.601 2.566 1 1 0 11-1.885.666A5.002 5.002 0 005.999 7H9a1 1 0 010 2H4a1 1 0 01-1-1V3a1 1 0 011-1zm.008 9.057a1 1 0 011.276.61A5.002 5.002 0 0014.001 13H11a1 1 0 110-2h5a1 1 0 011 1v5a1 1 0 11-2 0v-2.101a7.002 7.002 0 01-11.601-2.566 1 1 0 01.61-1.276z" clip-rule="evenodd" />
                            </svg>
                            Actualiser
                        </button>
                    </div>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
                <div class="bg-white rounded-xl shadow-md p-6 flex items-center justify-between overflow-hidden relative">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Locations Actives</p>
                        <p class="text-3xl font-bold text-gray-800" id="stat-active">--</p>
                        <p class="text-sm text-primary-600 mt-2">En cours cette semaine</p>
                    </div>
                    <div class="w-16 h-16 bg-primary-100 rounded-lg flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-primary-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                    <div class="absolute bottom-0 left-0 w-full h-1 bg-primary-500"></div>
                </div>

                <div class="bg-white rounded-xl shadow-md p-6 flex items-center justify-between overflow-hidden relative">
                    <div>
                        <p class="text-sm font-medium text-gray-500">À Venir</p>
                        <p class="text-3xl font-bold text-gray-800" id="stat-upcoming">--</p>
                        <p class="text-sm text-green-600 mt-2">Réservations futures</p>
                    </div>
                    <div class="w-16 h-16 bg-green-100 rounded-lg flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-green-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                        </svg>
                    </div>
                    <div class="absolute bottom-0 left-0 w-full h-1 bg-green-500"></div>
                </div>

                <div class="bg-white rounded-xl shadow-md p-6 flex items-center justify-between overflow-hidden relative">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Terminées</p>
                        <p class="text-3xl font-bold text-gray-800" id="stat-completed">--</p>
                        <p class="text-sm text-gray-600 mt-2">Ce mois-ci</p>
                    </div>
                    <div class="w-16 h-16 bg-gray-100 rounded-lg flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-gray-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                        </svg>
                    </div>
                    <div class="absolute bottom-0 left-0 w-full h-1 bg-gray-500"></div>
                </div>
            </div>

            <!-- Calendar Tabs & View Options -->
            <div class="bg-white rounded-xl shadow-md mb-6 overflow-hidden">
                <div class="flex items-center justify-between border-b border-gray-200 p-4">
                    <div class="flex space-x-1">
                        <button id="tab-month" class="px-4 py-2 font-medium text-sm rounded-lg bg-primary-100 text-primary-800">
                            Mensuel
                        </button>
                        <button id="tab-week" class="px-4 py-2 font-medium text-sm rounded-lg text-gray-600 hover:bg-gray-100">
                            Semaine
                        </button>
                        <button id="tab-day" class="px-4 py-2 font-medium text-sm rounded-lg text-gray-600 hover:bg-gray-100">
                            Jour
                        </button>
                    </div>
                    <div class="flex items-center space-x-2">
                        <div class="flex items-center space-x-1 text-sm mr-4">
                            <span class="w-3 h-3 rounded-full bg-primary-500"></span>
                            <span class="text-gray-600">En cours</span>
                        </div>
                        <div class="flex items-center space-x-1 text-sm mr-4">
                            <span class="w-3 h-3 rounded-full bg-green-500"></span>
                            <span class="text-gray-600">Confirmée</span>
                        </div>
                        <div class="flex items-center space-x-1 text-sm">
                            <span class="w-3 h-3 rounded-full bg-gray-400"></span>
                            <span class="text-gray-600">Terminée</span>
                        </div>
                        <div class="border-l border-gray-300 h-6 mx-4"></div>
                        <input type="text" id="event-search" placeholder="Rechercher..." class="bg-gray-100 border border-gray-300 rounded-lg px-3 py-1.5 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-primary-500">
                    </div>
                </div>

                <!-- Calendar Container -->
                <div id="calendar" class="overflow-hidden p-4"></div>
            </div>

            <!-- Event Details Modal (hidden by default) -->
            <div id="event-modal" class="hidden fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center">
                <div class="bg-white rounded-xl shadow-xl max-w-md w-full overflow-hidden">
                    <div class="bg-primary-600 px-6 py-4 text-white flex justify-between items-center">
                        <h3 class="text-xl font-bold">Détails de la Location</h3>
                        <button id="close-modal" class="text-white hover:text-gray-200">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>
                    <div class="p-6">
                        <div class="mb-4">
                            <p class="text-xs text-gray-500">Client</p>
                            <p class="text-gray-800 font-medium" id="modal-client">--</p>
                        </div>
                        <div class="mb-4">
                            <p class="text-xs text-gray-500">Véhicule</p>
                            <p class="text-gray-800 font-medium" id="modal-vehicle">--</p>
                        </div>
                        <div class="grid grid-cols-2 gap-4 mb-4">
                            <div>
                                <p class="text-xs text-gray-500">Date de début</p>
                                <p class="text-gray-800 font-medium" id="modal-start">--</p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-500">Date de fin</p>
                                <p class="text-gray-800 font-medium" id="modal-end">--</p>
                            </div>
                        </div>
                        <div class="mb-4">
                            <p class="text-xs text-gray-500">Montant total</p>
                            <p class="text-gray-800 font-bold" id="modal-amount">--</p>
                        </div>
                        <div class="mb-4">
                            <p class="text-xs text-gray-500">Statut</p>
                            <div class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-primary-100 text-primary-800" id="modal-status">
                                En cours
                            </div>
                        </div>
                        <div class="flex justify-end space-x-3 mt-6 pt-4 border-t border-gray-200">
                            <a href="#" id="modal-edit" class="px-4 py-2 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 transition-colors">
                                Modifier
                            </a>
                            <a href="#" id="modal-cancel" class="px-4 py-2 bg-red-100 text-red-700 rounded-lg hover:bg-red-200 transition-colors">
                                Annuler
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Toast Notification (hidden by default) -->
            <div id="toast" class="hidden fixed bottom-4 right-4 bg-green-500 text-white px-6 py-3 rounded-lg shadow-lg flex items-center transition-all duration-500">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <span id="toast-message">Opération réussie!</span>
            </div>
        </div>
    </div>
</div>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const calendarEl = document.getElementById('calendar');
                let currentView = 'dayGridMonth';

                // Initialize calendar with enhanced options
                const calendar = new FullCalendar.Calendar(calendarEl, {
                    initialView: currentView,
                    locale: 'fr',
                    headerToolbar: {
                        left: 'prev,next today',
                        center: 'title',
                        right: ''  // We'll handle this with our custom UI
                    },
                    events: '<%=request.getContextPath()%>/LocationEvents',
                    eventColor: '#0ea5e9',
                    firstDay: 1,
                    height: 'auto',
                    dayMaxEvents: true,
                    eventTimeFormat: {
                        hour: '2-digit',
                        minute: '2-digit',
                        meridiem: false,
                        hour12: false
                    },
                    eventClick: function(info) {
                        // Show modal with event details
                        document.getElementById('modal-client').textContent = info.event.extendedProps.client || 'Non spécifié';
                        document.getElementById('modal-vehicle').textContent = info.event.extendedProps.vehicle || 'Non spécifié';
                        document.getElementById('modal-start').textContent = formatDate(info.event.start);
                        document.getElementById('modal-end').textContent = formatDate(info.event.end);
                        document.getElementById('modal-amount').textContent = info.event.extendedProps.amount || '-- DT';

                        // Update status with appropriate styling
                        const statusEl = document.getElementById('modal-status');
                        statusEl.textContent = info.event.extendedProps.status || 'En cours';

                        // Status color styling
                        statusEl.className = 'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium';
                        if (statusEl.textContent === 'En cours') {
                            statusEl.classList.add('bg-primary-100', 'text-primary-800');
                        } else if (statusEl.textContent === 'Confirmée') {
                            statusEl.classList.add('bg-green-100', 'text-green-800');
                        } else if (statusEl.textContent === 'Terminée') {
                            statusEl.classList.add('bg-gray-100', 'text-gray-800');
                        }

                        // Set edit link
                        document.getElementById('modal-edit').href = `ModifierLocation.jsp?id=${info.event.id}`;
                        document.getElementById('modal-cancel').href = `LocationServlet?action=supprimer&id=${info.event.id}`;

                        // Show modal
                        document.getElementById('event-modal').classList.remove('hidden');
                    },
                    eventClassNames: function(arg) {
                        // Add custom styling based on status
                        if (arg.event.extendedProps.status === 'Confirmée') {
                            return ['border-l-4', 'border-green-500'];
                        } else if (arg.event.extendedProps.status === 'Terminée') {
                            return ['border-l-4', 'border-gray-400', 'opacity-75'];
                        }
                        return ['border-l-4', 'border-primary-500'];
                    },
                    datesSet: function(info) {
                        updateStats();
                    }
                });

                calendar.render();

                // Close modal
                document.getElementById('close-modal').addEventListener('click', function() {
                    document.getElementById('event-modal').classList.add('hidden');
                });

                // View tab handling
                document.getElementById('tab-month').addEventListener('click', function() {
                    setActiveTab(this);
                    calendar.changeView('dayGridMonth');
                    currentView = 'dayGridMonth';
                });

                document.getElementById('tab-week').addEventListener('click', function() {
                    setActiveTab(this);
                    calendar.changeView('timeGridWeek');
                    currentView = 'timeGridWeek';
                });

                document.getElementById('tab-day').addEventListener('click', function() {
                    setActiveTab(this);
                    calendar.changeView('timeGridDay');
                    currentView = 'timeGridDay';
                });

                // Helper for tab styling
                function setActiveTab(activeTab) {
                    // Reset all tabs
                    document.querySelectorAll('#tab-month, #tab-week, #tab-day').forEach(tab => {
                        tab.className = 'px-4 py-2 font-medium text-sm rounded-lg text-gray-600 hover:bg-gray-100';
                    });

                    // Set active tab
                    activeTab.className = 'px-4 py-2 font-medium text-sm rounded-lg bg-primary-100 text-primary-800';
                }

                // Date formatter helper
                function formatDate(date) {
                    if (!date) return 'Non spécifié';
                    return new Date(date).toLocaleDateString('fr-FR', {
                        day: '2-digit',
                        month: '2-digit',
                        year: 'numeric'
                    });
                }

                // Event search functionality
                document.getElementById('event-search').addEventListener('input', function() {
                    const searchTerm = this.value.toLowerCase();
                    calendar.getEvents().forEach(event => {
                        const title = event.title.toLowerCase();
                        const client = (event.extendedProps.client || '').toLowerCase();
                        const vehicle = (event.extendedProps.vehicle || '').toLowerCase();

                        if (title.includes(searchTerm) || client.includes(searchTerm) || vehicle.includes(searchTerm)) {
                            event.setProp('display', 'auto');
                        } else {
                            event.setProp('display', 'none');
                        }
                    });
                });

                // Refresh button
                document.getElementById('btn-refresh').addEventListener('click', function() {
                    // Visual feedback
                    this.classList.add('animate-pulse');

                    // Refresh events
                    calendar.refetchEvents().then(() => {
                        setTimeout(() => {
                            this.classList.remove('animate-pulse');
                            showToast('Calendrier actualisé');
                            updateStats();
                        }, 500);
                    });
                });

                // Stats counters
                function updateStats() {
                    const now = new Date();
                    let active = 0;
                    let upcoming = 0;
                    let completed = 0;

                    calendar.getEvents().forEach(event => {
                        const status = event.extendedProps.status;
                        const start = new Date(event.start);
                        const end = new Date(event.end);

                        if (status === 'En cours' || (start <= now && end >= now)) {
                            active++;
                        } else if (start > now) {
                            upcoming++;
                        } else if (status === 'Terminée' || end < now) {
                            completed++;
                        }
                    });

                    // Animate counters
                    animateCounter('stat-active', active);
                    animateCounter('stat-upcoming', upcoming);
                    animateCounter('stat-completed', completed);
                }

                function animateCounter(id, target) {
                    const el = document.getElementById(id);
                    const current = parseInt(el.innerText) || 0;
                    const increment = (target - current) / 20;
                    let count = current;

                    const timer = setInterval(() => {
                        count += increment;
                        el.innerText = Math.round(count);
                        if ((increment >= 0 && count >= target) || (increment < 0 && count <= target)) {
                            clearInterval(timer);
                            el.innerText = target;
                        }
                    }, 30);
                }

                // Toast notification
                function showToast(message) {
                    const toast = document.getElementById('toast');
                    document.getElementById('toast-message').textContent = message;

                    toast.classList.remove('hidden');
                    toast.classList.add('flex');

                    setTimeout(() => {
                        toast.classList.add('opacity-0', 'translate-y-2');
                        setTimeout(() => {
                            toast.classList.add('hidden');
                            toast.classList.remove('flex', 'opacity-0', 'translate-y-2');
                        }, 300);
                    }, 3000);
                }

                // Initial stats update
                setTimeout(updateStats, 500);

                // Close modal when clicking outside
                document.getElementById('event-modal').addEventListener('click', function(e) {
                    if (e.target === this) {
                        this.classList.add('hidden');
                    }
                });
            });
        </script>
</body>
</html>
