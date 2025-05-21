import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["time"]
  static values = { time: Number, running: Boolean }
  connect() {
    const initialDatetime = new Date()
    let initialDuration = this.timeValue
    this.timeTarget.innerHTML = this.format(initialDuration)
    if (this.runningValue) {
      setInterval(() => {
        let now = new Date()
        let timePassed = Math.floor((now - initialDatetime) / 1000) ;
        let timeLeft = initialDuration - timePassed;
        this.timeTarget.innerHTML = this.format(timeLeft)
      }, 1000)
    }
  }

  format(seconds) {
    const formattedTime = new Date(Math.abs(seconds) * 1000).toISOString().substring(11, 19)
    return `${seconds < 0 ? '-' : ''}${formattedTime}`
  }
}
