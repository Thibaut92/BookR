module MeetingsHelper
  def meeting_status_color(status)
    case status.to_sym
    when :proposed
      'warning'
    when :accepted
      'info'
    when :completed
      'success'
    when :rejected
      'danger'
    when :cancelled
      'secondary'
    else
      'primary'
    end
  end

  def format_price(amount)
    number_to_currency(amount, unit: '€', format: '%n %u')
  end

  def meeting_actions(meeting)
    if current_user.project_manager? && meeting.project_manager == current_user
      render 'project_manager_actions', meeting: meeting
    elsif current_user.industrial? && meeting.industrial == current_user
      render 'industrial_actions', meeting: meeting
    end
  end
end
