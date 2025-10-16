import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "form", "alert" ]

  connect() {
    this.dismissAlertHandler = (event) => this.hideAlert(event)

    if (this.hasAlertTarget) {
      this.alertTarget.addEventListener("close.bs.alert", this.dismissAlertHandler)
    }
  }

  disconnect() {
    if (this.hasAlertTarget) {
      this.alertTarget.removeEventListener("close.bs.alert", this.dismissAlertHandler)
    }
  }

  submit(event) {
    event.preventDefault()

    this.hideAlert()

    const form = this.formTarget

    if (!form.checkValidity()) {
      form.classList.add("was-validated")
      return
    }

    const formData = new FormData(form)

    fetch(form.action, { method: form.method, body: formData }).then((response) => {
      if (response.status === 201) {
        this.showAlert()
        form.reset()
        form.classList.remove("was-validated")
      } else {
        form.classList.add("was-validated")
      }
    })
  }

  hideAlert(event) {
    if (event) event.preventDefault()
    if (this.hasAlertTarget) {
      this.alertTarget.classList.add("d-none")
    }
  }

  showAlert() {
    if (this.hasAlertTarget) {
      this.alertTarget.classList.remove("d-none")
    }
  }
}
