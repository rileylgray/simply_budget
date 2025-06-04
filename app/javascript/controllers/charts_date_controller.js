import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["month", "year"]

  change() {
    const month = this.monthTarget.value
    const year = this.yearTarget.value

    // Reload the page with new params (or use Turbo to update just the charts)
    const url = new URL(window.location.href)
    url.searchParams.set("month", month)
    url.searchParams.set("year", year)
    window.location.href = url.toString()
  }
}