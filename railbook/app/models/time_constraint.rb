class TimeConstraint
  def matches?(request)
    current = Time.now
    current.hour >= 9 && current.hour < 23
  end
end
