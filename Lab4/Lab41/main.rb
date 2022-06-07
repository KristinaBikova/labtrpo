=begin
1. Написать набор методов для работы с файлом:
○ index - выводит все строки;
○ find(id) - находит конкретную строку в файле и выводит ее;
○ where(pattern) - находит все строки, где есть указанный
паттерн;
○ update(id, text) - обновляет конкретную строку файла;
○ delete(id) - удаляет строку;
где id = line number.
=end

def index(filename)
File.foreach(filename) { |student| puts student }
end

def find(filename,id) 
  File.foreach(filename).with_index do |student, index|
    if index == id then 
      puts student
      return student
      break
    end
  end
end
 
def where(filename,name)
File.foreach(filename).with_index do |student, index|
@student_id = index if student.include?(name)
end
@student_id
end

def update(filename,id, name)
file = File.open("BUFFER.txt", 'w')
File.foreach(filename).with_index do |student, index|
file.puts(id == index ? name : student)
end

file.close
File.write(filename,File.read("BUFFER.txt"))
File.delete("BUFFER.txt") if File.exist?("BUFFER.txt")
end


def delete(filename,id)
file = File.open("BUFFER.txt", 'w')
File.foreach(filename).with_index do |student, index|
  if id != index then 
    file.puts(student)
  end
end
file.close
File.write(filename,File.read("BUFFER.txt"))
File.delete("BUFFER.txt") if File.exist?("BUFFER.txt")
end

puts "Задание 1: \n"
puts "Метод index \n"
index("students.txt")
puts "\n"
puts "Метод find \n"
find("students.txt",0)
puts "\n"
puts "Метод where \n"
puts where("students.txt","Белякова")
puts "\n"
puts "Метод update \n"
update("students.txt",7, "Клыков Андрей Игоревич")
index("students.txt")
puts "\n"
puts "Метод delete \n"
delete("students.txt",8)
index("students.txt")
