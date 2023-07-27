import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["front", "msg", "back"]

  connect() {
	console.log('Hello', this.element)
  }

  gen() {
    const element = this.frontTarget
    const front = element.value
	console.log(this.msgTarget)

	if(front && front.length > 0) {
		console.log('OK')
		this.msgTarget.textContent = ""
		fetch('/cards/ai_gen_back' + "?front=" + front).then(response=>{
			if (!response.ok) {
				throw new Error('Network response was not ok');
			  }
			  return response.text();
		})
		.then(responseData => {
			var result = JSON.parse(responseData)
			console.log(result)
			this.backTarget.value = result.content
		})
		.catch(error => {
			console.error("Fetch error", error)
		})
	} else {
		console.log('Please enter the front')
		this.msgTarget.textContent = "Please enter the front"
	}
  }
}
