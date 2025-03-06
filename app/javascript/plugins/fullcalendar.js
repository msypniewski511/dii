import { Calendar } from '@fullcalendar/core'
import dayGridPlugin from '@fullcalendar/daygrid'
import interactionPlugin from '@fullcalendar/interaction'

// Ensure FullCalendar re-renders correctly on Turbo load
document.addEventListener('turbo:load', function () {
  const calendarEl = document.getElementById('calendar1')

  if (calendarEl) {
    // Destroy previous instance if exists
    if (window.fullCalendarInstance) {
      window.fullCalendarInstance.destroy()
    }

    // Create new calendar instance
    window.fullCalendarInstance = new Calendar(calendarEl, {
      plugins: [dayGridPlugin, interactionPlugin],
      themeSystem: 'bootstrap',
      initialView: 'dayGridMonth',
      headerToolbar: {
        start: 'title',
        center: '',
        end: 'today prev,next',
      },
      contentHeight: 'auto',
      events: [
        {
          title: 'Call with Dave',
          start: '2025-03-18',
          className: 'bg-gradient-danger',
        },
        {
          title: 'Lunch meeting',
          start: '2025-03-21',
          end: '2025-03-22',
          className: 'bg-gradient-warning',
        },
        {
          title: 'All day conference',
          start: '2025-03-29',
          className: 'bg-gradient-success',
        },
        {
          title: 'Meeting with Mary',
          start: '2025-03-01',
          className: 'bg-gradient-info',
        },
        {
          title: 'Winter Hackathon',
          start: '2025-03-03',
          className: 'bg-gradient-danger',
        },
        {
          title: 'Digital event',
          start: '2025-03-07',
          end: '2025-03-09',
          className: 'bg-gradient-warning',
        },
        {
          title: 'Marketing event',
          start: '2025-03-10',
          className: 'bg-gradient-primary',
        },
        {
          title: 'Dinner with Family',
          start: '2025-03-19',
          className: 'bg-gradient-danger',
        },
        {
          title: 'Black Friday',
          start: '2025-03-23',
          className: 'bg-gradient-info',
        },
        {
          title: 'Cyber Week',
          start: '2025-03-02',
          className: 'bg-gradient-warning',
        },
      ],
    })

    // Ensure rendering when switching tabs
    setTimeout(() => {
      window.fullCalendarInstance.render()
    }, 100)
  }
})

// Fix calendar layout issues when switching Bootstrap tabs
document.querySelectorAll('[data-bs-toggle="tab"]').forEach((tab) => {
  tab.addEventListener('shown.bs.tab', function () {
    if (window.fullCalendarInstance) {
      setTimeout(() => {
        window.fullCalendarInstance.render()
      }, 100)
    }
  })
})
