import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="answers"
export default class extends Controller {
  static targets = ["keywords", "msg", "content", "loading", "question"]

  connect() { }

  gen() {
    const element = this.keywordsTarget
    const keyword = element.value

    if(keyword && keyword.length > 0) {
      this.msgTarget.textContent = ""
      this.loadingTarget.className = "spinner-border"
      const qid = this.questionTarget.value
      fetch('/answers/ai_gen_content' + `?question_id=${qid}&keywords=` + keyword).then(response=>{
        if (!response.ok) {
          this.msgTarget.textContent = "Network response was not ok"
          throw new Error('');
          }
          return response.text();
      })
      .then(responseData => {
        this.loadingTarget.className = ""
        var result = JSON.parse(responseData)
        this.contentTarget.value = result.content
      })
      .catch(error => {
        console.error("Fetch error", error)
      })
    } else {
      this.msgTarget.textContent = "Please enter the keywords"
    }
  }

}
