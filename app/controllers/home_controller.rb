class HomeController < ApplicationController
  def show
    start_of_month = Date.current.beginning_of_month
    end_of_month = Date.current.end_of_month
    start_of_year = Date.current.beginning_of_year
    end_of_year = Date.current.end_of_year

    @monthly_income = total_income_for_period(current_user, start_of_month, end_of_month)
    @monthly_expenses = total_expense_for_period(current_user, start_of_month, end_of_month)
    @remaining = [ @monthly_income - @monthly_expenses, 0 ].max

    @yearly_income = total_income_for_period(current_user, start_of_year, end_of_year)
    @yearly_expenses = total_expense_for_period(current_user, start_of_year, end_of_year)
    @yearly_remaining = [ @yearly_income - @yearly_expenses, 0 ].max

    # Category spending for month
    @category_spending = category_expense_for_period(current_user, start_of_month, end_of_month)
    @category_labels = @category_spending.keys
    @category_amounts = @category_spending.values

    # Category spending for year
    @yearly_category_spending = category_expense_for_period(current_user, start_of_year, end_of_year)
    @yearly_category_labels = @yearly_category_spending.keys
    @yearly_category_amounts = @yearly_category_spending.values
  end

  private

  def total_income_for_period(user, period_start, period_end)
    Income.where(user: user).sum do |income|
      occurrences_in_period(
        start_date: income.received_on,
        end_date: income.try(:end_date),
        frequency: income.frequency,
        period_start: period_start,
        period_end: period_end
      ) * income.amount
    end
  end

  def total_expense_for_period(user, period_start, period_end)
    Expense.where(user: user).sum do |expense|
      occurrences_in_period(
        start_date: expense.spent_on,
        end_date: expense.try(:end_date),
        frequency: expense.frequency,
        period_start: period_start,
        period_end: period_end
      ) * expense.amount
    end
  end

  def category_expense_for_period(user, period_start, period_end)
    categories = Hash.new(0)
    Expense.includes(:expense_categories).where(user: user).find_each do |expense|
      count = occurrences_in_period(
        start_date: expense.spent_on,
        end_date: expense.try(:end_date),
        frequency: expense.frequency,
        period_start: period_start,
        period_end: period_end
      )
      label = expense.expense_categories.first&.name || "Uncategorized"
      categories[label] += expense.amount * count
    end
    categories
  end

  # Returns the number of times an event occurs in the given period
  def occurrences_in_period(start_date:, end_date:, frequency:, period_start:, period_end:)
    return 0 if start_date > period_end
    effective_end = [ end_date || period_end, period_end ].compact.min
    return 0 if effective_end < period_start

    case frequency.to_sym
    when :one_time
      (start_date >= period_start && start_date <= period_end) ? 1 : 0
    when :daily
      [ (effective_end - [ start_date, period_start ].max).to_i + 1, 0 ].max
    when :weekly
      count_occurrences(start_date, effective_end, period_start, period_end, 7)
    when :biweekly
      count_occurrences(start_date, effective_end, period_start, period_end, 14)
    when :monthly
      count_monthly_occurrences(start_date, effective_end, period_start, period_end)
    when :yearly
      count_yearly_occurrences(start_date, effective_end, period_start, period_end)
    else
      0
    end
  end

  def count_occurrences(start_date, end_date, period_start, period_end, interval_days)
    first = [ start_date, period_start ].max
    last = [ end_date, period_end ].min
    return 0 if first > last
    # Find the first occurrence on or after period_start
    offset = ((first - start_date) % interval_days)
    first_occurrence = first + (offset.zero? ? 0 : interval_days - offset)
    return 0 if first_occurrence > last
    (((last - first_occurrence) / interval_days).floor + 1).to_i
  end

  def count_monthly_occurrences(start_date, end_date, period_start, period_end)
    first = [ start_date, period_start ].max
    last = [ end_date, period_end ].min
    return 0 if first > last
    count = 0
    date = start_date
    while date < first
      date = date.next_month
    end
    while date <= last
      count += 1
      date = date.next_month
    end
    count
  end

  def count_yearly_occurrences(start_date, end_date, period_start, period_end)
    first = [ start_date, period_start ].max
    last = [ end_date, period_end ].min
    return 0 if first > last
    count = 0
    date = start_date
    while date < first
      date = date.next_year
    end
    while date <= last
      count += 1
      date = date.next_year
    end
    count
  end
end
