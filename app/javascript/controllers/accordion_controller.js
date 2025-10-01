import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle(event) {
    event.stopPropagation()
    const card = event.currentTarget.closest("[data-accordion-item]")
    const content = card.querySelector("[data-accordion-target='content']")
    const icon = card.querySelector("[data-accordion-target='icon']")

    // Close all other cards first
    this.element.querySelectorAll("[data-accordion-item]").forEach(item => {
      if (item !== card) {
        const otherContent = item.querySelector("[data-accordion-target='content']")
        const otherIcon = item.querySelector("[data-accordion-target='icon']")
        if (otherContent) otherContent.classList.add("hidden")
        if (otherIcon) otherIcon.textContent = "+"
      }
    })

    // Toggle current card
    content.classList.toggle("hidden")
    if (icon) icon.textContent = content.classList.contains("hidden") ? "+" : "–"
  }
}


