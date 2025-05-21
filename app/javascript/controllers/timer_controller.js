import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["time"]
  static values = { time: Number, running: Boolean }
  connect() {
    let time = this.timeValue
    this.timeTarget.innerHTML = this.format(time)
    if (this.runningValue) {
      setInterval(() => {
        this.timeTarget.innerHTML = this.format(--time)
      }, 1000)
    }
  }

  format(seconds) {
    const formattedTime = new Date(Math.abs(seconds) * 1000).toISOString().substring(11, 19)
    return `${seconds < 0 ? '-' : ''}${formattedTime}`
  }
}
