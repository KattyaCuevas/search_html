require 'nokogiri'
page = Nokogiri::HTML(File.open('RubyDiseoInstruccional.html'))
childrens = page.css('body').children
questions = []
id = 1
childrens.each_with_index do |element, index|
  next unless element.name == 'h3'
  next unless element.children[1].text == 'Cuestionario'
  20.times do |i|
    next if i.odd?
    ques = childrens[index + i + 1]
    answ = childrens[index + i + 2]
    question = {}
    question[:_id] = id
    question[:text] = ques.children[0].children.text
    question[:answers] = {}
    ans = 'a'
    answ.children.each do |child|
      question[:answers][ans] = child.children.first.text
      if answ.css("span[class='c3']").include?(child.children.first)
        question[:correct_answer] = ans
      end
      ans = ans.next
    end
    id += 1
    questions << question
  end
  puts 'fin'
end
puts questions
