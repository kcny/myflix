module ApplicationHelper
  def video_review_options(selected=nil)
    options_for_select((1..5).map {|num| [pluralize(num, "star"), num]}, selected)  
  end
end
