import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    handleResult(event) {
        const { success } = event.detail
        if (success) {
            // Optional: clear the form and show a tiny UI cue
            this.element.reset()
        }
    }
}
