# Write a class Employee that has attributes that return the employee's name, title, salary, and boss.
#
# Write another class, Manager, that extends Employee. Manager should have an attribute that holds an array of all employees assigned to the manager. Note that managers might report to higher level managers, of course.
#
# Add a method, bonus(multiplier) to Employee. Non-manager employees should get a bonus like this
#
# bonus = (employee salary) * multiplier
# Managers should get a bonus based on the total salary of all of their subordinates, as well as the manager's subordinates' subordinates, and the subordinates' subordinates' subordinates, etc.
#
# bonus = (total salary of all sub-employees) * multiplier
#
# If we have a company structured like this:
#
# Name	Salary	Title	Boss
# Ned	$1,000,000	Founder	nil
# Darren	$78,000	TA Manager	Ned
# Shawna	$12,000	TA	Darren
# David	$10,000	TA	Darren
# then we should have bonuses like this:


class Employee
  attr_reader :salary

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  #   raise StandardError unless boss.is_a?(Manager)
  # rescue
  #   retry
  end

  def bonus(multiplier)
    bonus = salary * multiplier
  end

end

class Manager < Employee
  attr_accessor :employees
  def initialize(name, title, salary, boss)
    super(name, title, salary, boss)
    @employees = []
  end

  def bonus(multiplier)
    self.add_employee
    base = @employees.reduce(0) {|accumulator, e| accumulator + e.salary}
    base * multiplier
  end

  def add_employee
    # return [] if
    @employees.each do |mini_boss|
      unless mini_boss
        break
      end
      if mini_boss.is_a?(Manager)
       mini_boss.employees.each do |minion|
         employees << minion unless employees.include?(minion)
       end
      end
    end
  end

  def add_employee_of(employee)
    @employees << employee
  end
end
# darren = []
# ned = []
ned = Manager.new("Ned", 1_000_000, "Founder", nil)
darren = Manager.new("Darren", "TA Manager", 78_000, ned)
shawna = Employee.new("Shawna", "TA", 12_000, darren)
david = Employee.new("David", "TA", 10_000, darren)
darren.add_employee_of(shawna)
darren.add_employee_of(david)
ned.add_employee_of(darren)
# p ned.employees
p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3)c # => 30_000
