class CashMachine
  def initialize
  @actual_balance = 0
  @BALANCE = 100
  @account = 'balance.txt'
end
# вывод терминала
def showCashMachineTerminal()
  puts 'Введите Вашу команду, чтобы продолжить'
  puts 'D - пополнение баланса'
  puts 'W - снятие наличных'
  puts 'B - вывод текущего баланса'
  puts 'Q - завершение работы'
end
  
# чтение баланса клиента из файла balance.txt
def readBalance()
  if File.exist?(@account) then
    File.foreach(@account) {|string| @actual_balance = string.to_i}
  else
    @actual_balance = @BALANCE
  end
end

# внести сумму
def deposit(amount)
  if isRefillAllowed?(amount) then
    @actual_balance += amount
  end
end

def isRefillAllowed?(amount)
  amount > 0 ? true : begin
    puts "Вы можете пополнить на сумму больше 0"
  end
end
  
# снять сумму
def withdraw(amount)
  if isWithdrawAllowed?(amount) then
    @actual_balance -= amount
  end
end

def isWithdrawAllowed?(amount)
  amount <= returnBalance() ? true : begin
    puts "Вы не можете снять больше, чем есть на счету"
  end
end
  
# проверить баланс
def showBalance()
  puts "Ваш текущий баланс: #{@balance}"
end


def returnBalance()
  @actual_balance
end

# выход
def quit()
  saveBalance()
end

# запись баланса в файл
def saveBalance()
  file = File.open("balance.txt", 'w')
  file.puts(@actual_balance)
  file.close
end

# распознавание команды
def checkCommand(command)
  case command.downcase
  when "d"
    puts "Введите сумму для пополнения"
    amount = gets.to_i
    deposit(amount)
  when "w"
    puts "Введите сумму для снятия"
    amount = gets.to_i
    withdraw(amount)
  when "b"
    @balance = returnBalance()
    showBalance()
  else
    puts "Команда не распознана."
  end
end


def init()
  command = "command"
  readBalance()
  loop do
    showCashMachineTerminal()
    command = gets.chomp
    command.downcase === "q" ? begin 
      quit()
      break 
    end 
    : checkCommand(command)
  end
end
end  
  readBalance = CashMachine.new()
  readBalance.readBalance()
readBalance.init()
