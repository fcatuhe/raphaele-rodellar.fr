import { Controller } from "@hotwired/stimulus"
import { ScrollSpy } from "bootstrap"

export default class extends Controller {
  static values = {
    target: String,
    rootMargin: String,
    smoothScroll: Boolean
  }

  connect() {
    this.scrollSpy = new ScrollSpy(this.element, {
      target: this.targetValue,
      rootMargin: this.rootMarginValue || "0px 0px 0px",
      smoothScroll: this.smoothScrollValue || false
    })
  }

  disconnect() {
    this.scrollSpy.dispose()
  }
}
