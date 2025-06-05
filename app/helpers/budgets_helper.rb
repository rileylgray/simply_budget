module BudgetsHelper
  def budget_period_range(budget)
    today = Date.current
    case budget.time_frame
    when "monthly"
      [ today.beginning_of_month, today.end_of_month ]
    when "weekly"
      [ today.beginning_of_week, today.end_of_week ]
    when "daily"
      [ today, today ]
    when "yearly"
      [ today.beginning_of_year, today.end_of_year ]
    else
      [ today.beginning_of_month, today.end_of_month ]
    end
  end

  # Returns how many times an expense occurs in the given period
  def occurrences_in_period(expense, period_start, period_end)
    start_date = [ expense.spent_on, period_start ].max
    end_date = [ expense.end_date || period_end, period_end ].min
    return 0 if start_date > end_date

    case expense.frequency.to_sym
    when :one_time
      (expense.spent_on >= period_start && expense.spent_on <= period_end) ? 1 : 0
    when :daily
      (end_date - start_date).to_i + 1
    when :weekly
      ((end_date - start_date).to_i / 7) + 1
    when :biweekly
      ((end_date - start_date).to_i / 14) + 1
    when :monthly
      ((end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month)) + 1
    when :yearly
      end_date.year - start_date.year + 1
    else
      1
    end
  end
end
