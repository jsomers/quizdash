module PlayHelper
  def answer_map(questions)
    map = {}
    questions.each_with_index do |q|
      q.permissible_answers.each {|pa| map[pa.downcase] = [q.id, pa]}
    end
    return map
  end
end
