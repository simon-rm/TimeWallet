import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["time", "calculatedTime"]

  connect() {
    this._recalc = this.recalculate.bind(this)

    this.timeTargets.forEach(el => {
      el.addEventListener("input",  this._recalc)
      el.addEventListener("change", this._recalc)
    })
  }

  recalculate() {
    // Sum all HH:MM values (treat blanks or bad input as 00:00)
    const usedMinutes = this.timeTargets.reduce((total, el) => {
      const match = el.value.match(/^(\d{1,2}):(\d{2})$/) || []
      const hours   = parseInt(match[1] || 0, 10)
      const minutes = parseInt(match[2] || 0, 10)
      return total + hours * 60 + minutes
    }, 0)

    let remaining = 24 * 60 - usedMinutes
    if (remaining < 0) remaining = 0 // clamp to 00:00 if they go over

    const hours   = String(Math.floor(remaining / 60)).padStart(2, "0")
    const minutes = String(remaining % 60).padStart(2, "0")
    this.calculatedTimeTarget.value = `${hours}:${minutes}`
  }
}
