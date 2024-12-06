import { Controller } from "@hotwired/stimulus"
import { Calendar } from '@fullcalendar/core'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import interactionPlugin from '@fullcalendar/interaction'
import frLocale from '@fullcalendar/core/locales/fr'

export default class extends Controller {
  static targets = ["calendar"]

  connect() {
    this.calendar = new Calendar(this.calendarTarget, {
      plugins: [dayGridPlugin, timeGridPlugin, interactionPlugin],
      initialView: 'dayGridMonth',
      locale: frLocale,
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay'
      },
      buttonText: {
        today: "Aujourd'hui",
        month: 'Mois',
        week: 'Semaine',
        day: 'Jour'
      },
      selectable: true,
      editable: true,
      events: '/meetings.json',
      select: this.handleDateSelect.bind(this),
      eventClick: this.handleEventClick.bind(this),
      eventDrop: this.handleEventDrop.bind(this),
      eventResize: this.handleEventResize.bind(this)
    })

    this.calendar.render()
  }

  handleDateSelect(selectInfo) {
    // Remplir les champs cachés de date dans le formulaire
    document.querySelector('input[name="meeting[start_time]"]').value = selectInfo.startStr
    document.querySelector('input[name="meeting[end_time]"]').value = selectInfo.endStr

    // Afficher le modal
    const modal = new bootstrap.Modal(document.getElementById('meetingModal'))
    modal.show()

    this.calendar.unselect()
  }

  handleEventClick(clickInfo) {
    if (confirm('Voulez-vous supprimer ce rendez-vous ?')) {
      fetch(`/meetings/${clickInfo.event.id}`, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
        }
      })
      .then(response => {
        if (response.ok) {
          clickInfo.event.remove()
        }
      })
    }
  }

  handleEventDrop(dropInfo) {
    this.updateEvent(dropInfo.event)
  }

  handleEventResize(resizeInfo) {
    this.updateEvent(resizeInfo.event)
  }

  updateEvent(event) {
    fetch(`/meetings/${event.id}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({
        meeting: {
          start_time: event.start,
          end_time: event.end
        }
      })
    })
  }

  disconnect() {
    if (this.calendar) {
      this.calendar.destroy()
    }
  }
}
