// app/javascript/controllers/flash_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.classList.add('fade-out')
      setTimeout(() => {
        this.element.style.display = 'none'
      }, 500) // 500ms is the duration of the fade-out animation
    }, 5000) // 5000ms = 5 seconds
  }
}