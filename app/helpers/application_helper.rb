module ApplicationHelper
  def pretty_time(seconds)
    mins = (seconds / 60).to_i
    secs = (seconds % 60).to_i
    mins = (mins < 10 ? "0#{mins}" : mins)
    secs = (secs < 10 ? "0#{secs}" : secs)
    "#{mins}:#{secs}"
  end
end
