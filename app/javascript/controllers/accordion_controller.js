import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="accordion"
export default class extends Controller {
  static targets = ["content", "icon"]

  connect() {
    this.isOpen = false
    this.update()
  }

  toggle() {
    this.isOpen = !this.isOpen
    this.update()
  }

  update() {
    if (this.hasContentTarget) {
      this.contentTarget.classList.toggle("hidden", !this.isOpen)
    }
    if (this.hasIconTarget) {
      this.iconTarget.textContent = this.isOpen ? "−" : "+"
      this.iconTarget.setAttribute("aria-expanded", String(this.isOpen))
    }
  }
}


