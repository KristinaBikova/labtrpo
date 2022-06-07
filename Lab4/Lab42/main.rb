# вывод файла на экран
def index(filename)
  File.foreach(filename).with_index do |item, index|
    puts(item)
  end
end

# чтение файла в массив,возврат массива
def file_to_array(filename) 
  arr = [];
  File.foreach(filename).with_index do |item, index|
    obj = item.split
    obj.push(index)
    arr.push(obj)
  end
  arr
end

# запись в файл неподходях по возрасту студентов
def write_rest(filename, arr1, arr2)
  arr2.each {|item2| begin
    arr1.each {|item1| begin
      if item1[4].to_i == item2[4].to_i then
        arr1.delete(item1)
      end
    end}
  end}

  overwrite_file(filename, arr1)
end

# дозапись в файл из массива
def write_to_file(filename, arr)
  file = File.open("buffer.txt", 'w')
  File.foreach(filename).with_index do |item, index|
    file.puts(item)
  end
  arr.each_with_index { |item, index| begin   
    item.pop
    file.puts(item.join(" ")) 
  end}
  file.close
  File.write(filename, File.read("buffer.txt"))
  File.delete("buffer.txt") if File.exist?("buffer.txt")
end

# перезапись файла из массива
def overwrite_file(filename, arr)
  file = File.open(filename, 'w')
  file.puts("\n")
  File.foreach(filename).with_index do |item, index|
    file.puts(item)
  end
  arr.each_with_index { |item, index| begin 
    item.pop
    file.puts(item.join(" ")) 
  end}
  file.close
end

# поиск по возрасту в массиве
def find_by_age(arr, age)
  res = []
  arr.each {|item| item[3].to_i == age ? res.push(item) : false }
  res
end

# конвертация одномерного массива в строку
def arr_to_str(arr)
  arr.join(" ")
end

# пуст ли файл
def is_file_empty(filename) 
  File.zero?(filename)
end
  

age = 21
until age == -1 do
  # читаем файл students.txt и записываем данные в массив
  arr = file_to_array("students.txt")

  
  if arr.length == 0 then 
    break
  end
 
  if arr.length > 0 then
    arr[arr.length-1].length < 2? break : false;
  end

  
  puts "Введите Ваш возраст"
  age = gets.to_i

  # составляем массив всех студентов этого возраста
  res = find_by_age(arr, age)
  
  # пишем массив в result.txt
  write_to_file("result.txt", res)

  write_rest("students.txt", arr, res)
end

# выводим файл result.txt
index("result.txt")