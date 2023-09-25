import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="card"
export default class extends Controller {
  static targets = ["source", "msg"]
  connect() {
    console.log('in card controller......')
  }

  copy(event) {
    event.preventDefault()
    navigator.clipboard.writeText(this.sourceTarget.innerText);
    this.msgTarget.innerText = "Copied!"
  }
}
