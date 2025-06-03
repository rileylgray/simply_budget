import { Controller } from "@hotwired/stimulus"

const CHARTS = [
  "spendingIncomePie",
  "monthlyCategoryBar",
  "yearlySpendingIncomePie",
  "yearlyCategoryBar"
]

const GROUPS = {
  monthly: ["spendingIncomePie", "monthlyCategoryBar"],
  yearly: ["yearlySpendingIncomePie", "yearlyCategoryBar"]
}

export default class extends Controller {
    adjustPieChartColumns() {
        const monthPie = document.getElementById("spendingIncomePie-card");
        const yearPie = document.getElementById("yearlySpendingIncomePie-card");
        const monthVisible = monthPie && monthPie.style.display !== "none";
        const yearVisible = yearPie && yearPie.style.display !== "none";

        // Remove all col classes first
        [monthPie, yearPie].forEach(card => {
            if (card) card.classList.remove("col-12", "col-md-6");
        });

        if (monthVisible && yearVisible) {
            if (monthPie) monthPie.classList.add("col-12", "col-md-6");
            if (yearPie) yearPie.classList.add("col-12", "col-md-6");
        } else if (monthVisible) {
            if (monthPie) monthPie.classList.add("col-12");
        } else if (yearVisible) {
            if (yearPie) yearPie.classList.add("col-12");
        }
    }

    toggleCharts(charts) {
    let state = this.loadState();
    charts.forEach(chart => {
        state[chart] = !state[chart];
        this.setChartVisibility(chart, state[chart]);
    });
    this.saveState(state);
    this.updateCheckmarks();
    this.adjustPieChartColumns(); // <-- Make sure this is called here
    }

    // Also call on connect to set initial state:
    connect() {
        this.loadState();
        this.setupDropdown();
        this.updateCheckmarks();
        this.adjustPieChartColumns();
    }

    setupDropdown() {
    const menu = document.getElementById("chart-toggle-menu")
    if (!menu) return

    menu.querySelectorAll("[data-chart-toggle]").forEach(item => {
        item.addEventListener("click", (e) => {
        e.preventDefault()
        const chart = item.dataset.chartToggle
        const group = item.dataset.chartGroup
        if (group === "monthly" || group === "yearly") {
            this.toggleCharts(GROUPS[group])
        } else {
            this.toggleCharts([chart])
        }
        // No need to call updateCheckmarks or adjustPieChartColumns here
        })
    })
    }

  setChartVisibility(chart, visible) {
    const card = document.getElementById(`${chart}-card`)
    if (card) card.style.display = visible ? "" : "none"
  }

  loadState() {
    let state = {}
    try {
      state = JSON.parse(window.localStorage.getItem("chartVisibility") || "{}")
    } catch {}
    // Default: all visible unless set
    CHARTS.forEach(chart => {
      if (typeof state[chart] === "undefined") state[chart] = true
      this.setChartVisibility(chart, state[chart])
    })
    return state
  }

  saveState(state) {
    window.localStorage.setItem("chartVisibility", JSON.stringify(state))
  }

  updateCheckmarks() {
    let state = this.loadState()
    // Individual charts
    CHARTS.forEach(chart => {
      document.querySelectorAll(`[data-chart-check="${chart}"]`).forEach(el => {
        el.innerHTML = state[chart] ? "✔️" : ""
      })
    })
    // Groups
    Object.entries(GROUPS).forEach(([group, charts]) => {
      const allEnabled = charts.every(chart => state[chart])
      document.querySelectorAll(`[data-chart-check="${group}"]`).forEach(el => {
        el.innerHTML = allEnabled ? "✔️" : ""
      })
    })
  }
}