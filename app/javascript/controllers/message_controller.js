import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {sender: String, id: String, read: Boolean}
  static targets = [ "contentDiv", "popup", "innerDiv", "read" ]
  connect() {
    const userId = document.getElementById("userId").dataset.id
    if (userId !== this.senderValue) {
      this.setClasses()
      if (!this.readValue) {
        this.setRead()
      }
    }
  }
    setClasses() {
      this.element.classList = "w-full flex flex-col"
      this.contentDivTarget.classList = "bg-stone-800 text-white p-4 rounded-3xl rounded-bl self-start max-w-[100%]"
      this.innerDivTarget.classList = "self-start flex gap-2 items-center max-w-[75%]"
      this.popupTarget.classList = 'hidden'
      this.readTarget.remove()
    }
    setRead() {
      fetch(`/messages/${this.idValue}/setread`, {
        method: "GET",
        headers: {
        'Accept': 'text/vnd.turbo-stream.html'
      }
      })
    }

}
