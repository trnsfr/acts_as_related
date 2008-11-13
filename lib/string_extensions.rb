module ActiveSupport::CoreExtensions::String::Inflections
  # Extremely silly, but extremely useful methods

  def collapse(first,last=first)
    first(first).gsub(/^A /, "").chomp(" ") + "..." + last(last).gsub(/^A /, "").chomp(" ")
  end
  

  def modelize
    classify.constantize
  end
  
  
  def instantize
    underscore.downcase
  end

end
