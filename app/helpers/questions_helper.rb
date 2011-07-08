module QuestionsHelper
  def nested_questions(qustions)
    qustions.map do |qustion, sub_qustions|
      render(qustion) + content_tag(:div, nested_questions(sub_qustions), :class => "nested_questions")
    end.join.html_safe
  end
end
