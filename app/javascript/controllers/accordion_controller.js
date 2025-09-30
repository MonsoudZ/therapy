import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="accordion"
export default class extends Controller {
  static targets = ["content", "icon"]

  connect() {
    this.isOpen = false
    this.boundExternalOpen = this.handleExternalOpen.bind(this)
    window.addEventListener("service:open", this.boundExternalOpen)
    this.update()
  }

  disconnect() {
    window.removeEventListener("service:open", this.boundExternalOpen)
  }

  toggle() {
    if (this.isOpen) {
      this.close()
    } else {
      this.open()
    }
  }

  open() {
    // Tell others to close
    window.dispatchEvent(new CustomEvent("service:open", { detail: { source: this.element } }))
    this.isOpen = true
    this.update()
  }

  close() {
    this.isOpen = false
    this.update()
  }

  handleExternalOpen(event) {
    const { source } = event.detail || {}
    if (source && source !== this.element && this.isOpen) {
      this.close()
    }
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


