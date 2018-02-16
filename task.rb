require 'date'

class TaskList
  attr_accessor :duetasksort

  def initialize
    @taskList = []
    @finalSort = []
  end

  def addTask (x)
    @taskList << x
  end

  def showList
    @taskList
  end

  def completedTasks
    @taskList.select {|x| x.show_status == true}
  end

  def incompleteTasks
    @taskList.select {|x| x.show_status == false}
  end

  def incompleteTasksDueToday
    @taskList.select {|x| x.show_status == false && x.showDueDate == Date.today}
  end

  def sortedIncompleteTasks
    @selected = @taskList.select {|x| x.show_status == false}
    @sorted = @selected.sort{|a, b| a.showDueDate <=> b.showDueDate}
  end

  def separateTasks
    @regtask = @taskList.select {|x| x.showTask == "Regular Task"}
    @duetask = @taskList.select {|x| x.showTask == "Due Date Task"}
    @duetasksort = @duetask.sort{|a, b| a.showDueDate <=> b.showDueDate}
    @duetasksort.each {|t| @finalSort << t}
    @regtask.each {|t| @finalSort << t}

  end

  def showSort
    @sorted
  end

  def showFinalSort
    @finalSort
  end

end

class Task
 def initialize taskTitle, taskDescription
   @title = taskTitle
   @description = taskDescription
   @status = false
   @task = "Regular Task"
 end

 def title
   @title
 end

 def description
   @description
 end

 def done
  if @status == false
     @status = true
  else @status = false
 end
end

 def status
  if @status == false
    return "Task not completed"
  elsif @status == true
    return "Task completed"
  end
 end

 def show_status
   @status
 end

 def showTask
   @task
 end
end

class Duedate < Task
  def initialize taskTitle, taskDescription
    super
    @dueDate
    @task = "Due Date Task"
    @anniversary
  end

  def anniversary date
    @anniversary = Date.parse(date)
  end

  def setDueDate date
    @dueDate = Date.parse(date)
  end

  def showAnniversary
    @anniversary
  end

  def showDueDate
    @dueDate
  end

  def showTask
    @task
  end

  def setDDforAnn
    if @anniversary > Date.today
      @dueDate = @anniversary
    elsif @anniversary < Date.today
      @dueDate = @anniversary + 365
    end
  end
end
