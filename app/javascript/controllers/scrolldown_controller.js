import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  connect() {
    const container = this.element
    container.scrollTop = container.scrollHeight - container.clientHeight

    container.addEventListener('scroll', () => {
      console.log(container.clientHeight, container.scrollHeight, container.scrollTop)
            console.log(container.scrollHeight - container.clientHeight - container.scrollTop)
    })

    const observer = new MutationObserver((mutationList, observer) => {
        for (const mutation of mutationList) {
          console.log(container.clientHeight, container.scrollHeight, container.scrollTop)
            if (container.scrollHeight - container.clientHeight - container.scrollTop < 240){
            container.scrollTop = container.scrollHeight - container.clientHeight
            }
        }
    })

    observer.observe(container, {childList: true})
  }
}
