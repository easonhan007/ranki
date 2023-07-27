import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["front", "msg", "back", "loading"]

  connect() {
	console.log('cards controller', this.element)
  }

  gen() {
    const element = this.frontTarget
    const front = element.value

	if(front && front.length > 0) {
		this.msgTarget.textContent = ""
		this.loadingTarget.className = "spinner-border"
		fetch('/cards/ai_gen_back' + "?front=" + front).then(response=>{
			if (!response.ok) {
				this.msgTarget.textContent = "Network response was not ok"
				throw new Error('');
			  }
			  return response.text();
		})
		.then(responseData => {
			this.loadingTarget.className = ""
			var result = JSON.parse(responseData)
			this.backTarget.value = result.content
		})
		.catch(error => {
			console.error("Fetch error", error)
		})
	} else {
		this.msgTarget.textContent = "Please enter the front"
	}
  }
}
