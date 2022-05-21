=begin
Написать скрипт, который будет принимать слово. Если слово
заканчивается на “CS” - выводит на экран цифру 2 в степени (длины
введенного слова), если не заканчивается - выводит слово задом
наперед.
=end

require "rspec/autorun"


def replacing(str)
  if str.end_with?("cs")
    c = 2**str.size
    puts "Слово заканчивается на (cs), выводим число 2 в степени длины введеного слова #{c}"
    c
  else
    puts "Слово не заканчивается на (cs), выводим слово задом наперед "
    puts str.reverse
    str.reverse
  end
end

puts "Введите слово"
str = gets.chop
replacing(str)


RSpec.describe 'replacing' do
  context "do_replacing" do
    it '#replacing' do
      expect(replacing("hello")).to eq("olleh")
    end
    it '#replacing' do
      expect(replacing("hellocs")).to eq(128)
    end
  end
end 


=begin
Написать скрипт, который будет выводить массив покемонов:
○ Спросит, сколько покемонов добавить.
○ Указанное на предыдущем этапе число раз, спросит имя и
цвет каждого покемона.
○ Выведет в консоль массив, содержащий хеши покемонов в
формате:
[{ name: 'Pikachu', color: 'Yellow' }, … n times{}]
=end

def pokemon (pokemon)
  arr = []
  arr.push(pokemon)
  arr
end

def show_pokemon(arr)
  arr.length.times do |index|
    puts arr[index]
  end
end

puts "\n"

puts "Сколько покемонов добавить?"
arr = []
countpokemons = gets.to_i
 i = 1
  while (i <= countpokemons) do 
    puts "Имя"
    name = gets.chop
    puts "Цвет"
    color = gets.chop
    pokemonmain ={name: name, color: color}
    arr.push(pokemonmain)
    i +=1
  end 

show_pokemon(arr)


RSpec.describe 'pokemon' do
  context "do_pokemon" do
    pokemonmain = { 'name' => "Сема", 'color' => "блондин" }
    it '#pokemon' do
      expect(pokemon(pokemonmain)).to include(pokemonmain)
    end 
  end
end 
