import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    monthlyIncome: Number,
    monthlyExpenses: Number,
    remaining: Number,
    yearlyIncome: Number,
    yearlyExpenses: Number,
    yearlyRemaining: Number,
    categoryLabels: Array,
    categoryAmounts: Array,
    yearlyCategoryLabels: Array,
    yearlyCategoryAmounts: Array,
    categoryColours: Array,
    yearlyCategoryColours: Array,
    incomeCategoryLabelsMonth: Array,
    incomeCategoryAmountsMonth: Array,
    incomeCategoryLabelsYear: Array,
    incomeCategoryAmountsYear: Array,
    incomeCategoryColours: Array,
    incomeCategoryColoursYear: Array
  }

  connect() {
    // Monthly Pie
    if (this.monthlyIncomeValue > 0 || this.monthlyExpensesValue > 0) {
      const ctx = document.getElementById('spendingIncomePie').getContext('2d');
      new Chart(ctx, {
        type: 'pie',
        data: {
          labels: ['Spent', 'Remaining Income'],
          datasets: [{
            data: [this.monthlyExpensesValue, this.remainingValue],
            backgroundColor: [
              'rgba(220, 53, 69, 0.7)',
              'rgba(25, 135, 84, 0.7)'
            ],
            borderColor: [
              'rgba(220, 53, 69, 1)',
              'rgba(25, 135, 84, 1)'
            ],
            borderWidth: 1
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: { position: 'bottom' },
            tooltip: {
              callbacks: {
                label: function(context) {
                  let label = context.label || '';
                  let value = context.parsed || 0;
                  return `${label}: $${value.toLocaleString()}`;
                }
              }
            }
          }
        }
      });
    }

    // Yearly Pie
    if (this.yearlyIncomeValue > 0 || this.yearlyExpensesValue > 0) {
      const yctx = document.getElementById('yearlySpendingIncomePie').getContext('2d');
      new Chart(yctx, {
        type: 'pie',
        data: {
          labels: ['Spent', 'Remaining Income'],
          datasets: [{
            data: [this.yearlyExpensesValue, this.yearlyRemainingValue],
            backgroundColor: [
              'rgba(220, 53, 69, 0.7)',
              'rgba(25, 135, 84, 0.7)'
            ],
            borderColor: [
              'rgba(220, 53, 69, 1)',
              'rgba(25, 135, 84, 1)'
            ],
            borderWidth: 1
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: { position: 'bottom' },
            tooltip: {
              callbacks: {
                label: function(context) {
                  let label = context.label || '';
                  let value = context.parsed || 0;
                  return `${label}: $${value.toLocaleString()}`;
                }
              }
            }
          }
        }
      });
    }

    // Monthly Category Bar
    if (this.categoryLabelsValue.length > 0) {
      const barCtx = document.getElementById('monthlyCategoryBar').getContext('2d');
      new Chart(barCtx, {
        type: 'bar',
        data: {
          labels: this.categoryLabelsValue,
          datasets: [{
            label: 'Spent',
            data: this.categoryAmountsValue,
            backgroundColor: this.categoryColoursValue.length === this.categoryLabelsValue.length
              ? this.categoryColoursValue
              : 'rgba(220, 53, 69, 0.7)',
            borderColor: this.categoryColoursValue.length === this.categoryLabelsValue.length
              ? this.categoryColoursValue
              : 'rgba(220, 53, 69, 1)',
            borderWidth: 1
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: { display: false },
            tooltip: {
              callbacks: {
                label: function(context) {
                  let value = context.parsed.y || 0;
                  return `Spent: $${value.toLocaleString()}`;
                }
              }
            }
          },
          scales: {
            y: {
              beginAtZero: true,
              ticks: {
                callback: function(value) {
                  return '$' + value.toLocaleString();
                }
              }
            }
          }
        }
      });
    }

    // Yearly Category Bar
    if (this.yearlyCategoryLabelsValue.length > 0) {
      const yearlyBarCtx = document.getElementById('yearlyCategoryBar').getContext('2d');
      new Chart(yearlyBarCtx, {
        type: 'bar',
        data: {
          labels: this.yearlyCategoryLabelsValue,
          datasets: [{
            label: 'Spent',
            data: this.yearlyCategoryAmountsValue,
            backgroundColor: this.yearlyCategoryColoursValue.length === this.yearlyCategoryLabelsValue.length
              ? this.yearlyCategoryColoursValue
              : 'rgba(220, 53, 69, 0.7)',
            borderColor: this.yearlyCategoryColoursValue.length === this.yearlyCategoryLabelsValue.length
              ? this.yearlyCategoryColoursValue
              : 'rgba(220, 53, 69, 1)',
            borderWidth: 1
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: { display: false },
            tooltip: {
              callbacks: {
                label: function(context) {
                  let value = context.parsed.y || 0;
                  return `Spent: $${value.toLocaleString()}`;
                }
              }
            }
          },
          scales: {
            y: {
              beginAtZero: true,
              ticks: {
                callback: function(value) {
                  return '$' + value.toLocaleString();
                }
              }
            }
          }
        }
      });
    }
    debugger
    if (this.incomeCategoryLabelsMonthValue.length > 0) {
      const barCtx = document.getElementById('monthlyIncomeCategoryBar').getContext('2d');
      new Chart(barCtx, {
        type: 'bar',
        data: {
          labels: this.incomeCategoryLabelsMonthValue,
          datasets: [{
            label: 'Income',
            data: this.incomeCategoryAmountsMonthValue,
            backgroundColor: this.incomeCategoryColoursValue.length === this.incomeCategoryLabelsMonthValue.length
              ? this.incomeCategoryColoursValue
              : '#4CAF50',
            borderColor: this.incomeCategoryColoursValue.length === this.incomeCategoryLabelsMonthValue.length
              ? this.incomeCategoryColoursValue
              : '#388E3C',
            borderWidth: 1
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: { display: false },
            tooltip: {
              callbacks: {
                label: function(context) {
                  let value = context.parsed.y || 0;
                  return `Income: $${value.toLocaleString()}`;
                }
              }
            }
          },
          scales: {
            y: {
              beginAtZero: true,
              ticks: {
                callback: function(value) {
                  return '$' + value.toLocaleString();
                }
              }
            }
          }
        }
      });
    }

    // Yearly Income by Category Bar
    if (this.incomeCategoryLabelsYearValue.length > 0) {
      const barCtx = document.getElementById('yearlyIncomeCategoryBar').getContext('2d');
      new Chart(barCtx, {
        type: 'bar',
        data: {
          labels: this.incomeCategoryLabelsYearValue,
          datasets: [{
            label: 'Income',
            data: this.incomeCategoryAmountsYearValue,
            backgroundColor: this.incomeCategoryColoursYearValue.length === this.incomeCategoryLabelsYearValue.length
              ? this.incomeCategoryColoursYearValue
              : '#4CAF50',
            borderColor: this.incomeCategoryColoursYearValue.length === this.incomeCategoryLabelsYearValue.length
              ? this.incomeCategoryColoursYearValue
              : '#388E3C',
            borderWidth: 1
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: { display: false },
            tooltip: {
              callbacks: {
                label: function(context) {
                  let value = context.parsed.y || 0;
                  return `Income: $${value.toLocaleString()}`;
                }
              }
            }
          },
          scales: {
            y: {
              beginAtZero: true,
              ticks: {
                callback: function(value) {
                  return '$' + value.toLocaleString();
                }
              }
            }
          }
        }
      });
    }
  }
}