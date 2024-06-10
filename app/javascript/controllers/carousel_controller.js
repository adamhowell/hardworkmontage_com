// app/javascript/controllers/carousel_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slide"]

  initialize() {
    this.showSlide(0)
  }

  next() {
    this.showSlide((this.index + 1) % this.slideTargets.length)
  }

  previous() {
    this.showSlide((this.index - 1 + this.slideTargets.length) % this.slideTargets.length)
  }

  showSlide(index) {
    this.index = index
    this.slideTargets.forEach((el, i) => {
      el.style.display = i === index ? "block" : "none"
    })
  }
}
