<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Calendrier des Locations | ELGarage</title>

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
</head>
<body class="bg-gray-100 font-sans">
<!-- barre de navigation, sidebar, etc. -->
<div class="ml-64 p-6">
    <h1 class="text-2xl font-bold mb-4">Calendrier des Locations</h1>
    <div id="calendar"></div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const calendarEl = document.getElementById('calendar');
        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'fr',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            events: '<%=request.getContextPath()%>/LocationEvents',
            eventColor: '#0ea5e9',
            firstDay: 1
        });
        calendar.render();
    });
</script>

</body>
</html>
