import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

export default class extends Controller {
  static targets = [ "card", "front", "modal" ]

  connect() {
    this.modal = new Modal(this.modalTarget)
  }

  disconnect() {
    this.modal.dispose()
  }

  toggle(event) {
    this.cardTarget.classList.toggle("flipped")

    if (this.frontTarget.contains(event.target)) {
      event.preventDefault()
      this.modal.show()
    }
  }

  hideModal(event) {
    event.preventDefault()
    event.stopPropagation()
    this.modal.hide()
  }
}
