import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log('from hello controller')
  }

  newCard(e) {
    if(e.ctrlKey && e.code == 'KeyN') {
      window.location = "/cards/new"
    }
  }
}
