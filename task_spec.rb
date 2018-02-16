require 'rspec'
require_relative 'task'
require 'date'

describe Task do
  it "has to be real" do
    expect {Task.new("Task1", "Go for a run")}.to_not raise_error
  end

  it "has a title" do
    task1 = Task.new("Task1", "Go for a run")
    expect(task1.title).to be_a String
  end

  it "has a description" do
    task1 = Task.new("Task1", "Go for a run")
    expect(task1.description).to be_a String
  end

  it "displays status" do
    task1 = Task.new("Task1", "Go for a run")
    expect(task1.status).to be_a String
  end

  it "changes status" do
    task1 = Task.new("Task1", "Go for a run")
    expect(task1.done).to be_truthy
  end
end

describe TaskList do
  it "has to be real" do
    expect {TaskList.new}.to_not raise_error
  end

  it "can add tasks to task list" do
    a_tasklist = TaskList.new
    a_task1 = Task.new("Task1", "Go for a run")
    a_task2 = Task.new("Task2", "Eat brkfst")
    a_task3 = Task.new("Task3", "School")
    a_tasklist.addTask a_task1
    a_tasklist.addTask a_task2
    a_tasklist.addTask a_task3
    expect(a_tasklist.showList.length).to be 3
  end

  it "can find completed tasks" do
    a_tasklist = TaskList.new
    a_task1 = Task.new("Task1", "Go for a run")
    a_task2 = Task.new("Task2", "Eat brkfst")
    a_task2.done
    a_task3 = Task.new("Task3", "School")
    a_tasklist.addTask a_task1
    a_tasklist.addTask a_task2
    a_tasklist.addTask a_task3
    expect(a_tasklist.completedTasks.length).to be 1
  end

  it "can find incomplete tasks" do
    a_tasklist = TaskList.new
    a_task1 = Task.new("Task1", "Go for a run")
    a_task2 = Task.new("Task2", "Eat brkfst")
    a_task2.done
    a_task3 = Task.new("Task3", "School")
    a_tasklist.addTask a_task1
    a_tasklist.addTask a_task2
    a_tasklist.addTask a_task3
    expect(a_tasklist.incompleteTasks.length).to be 2
  end
end

describe Duedate do
    it "creates a due date" do
      task1 = Duedate.new("Task1", "Go for a run")
      task1.setDueDate ("Today is Feb 16, 2018")
      expect(task1.showDueDate).to be_a Date
    end

    it "can find incomplete tasks due today" do
      a_tasklist = TaskList.new
      a_task1 = Duedate.new("Task1", "Go for a run")
      a_task1.setDueDate ("feb 15, 2018")
      a_task2 = Duedate.new("Task2", "Eat brkfst")
      a_task2.done
      a_task2.setDueDate ("feb 15, 2018")
      a_task3 = Duedate.new("Task3", "School")
      a_task3.setDueDate ("feb 15, 2018")
      a_task4 = Duedate.new("Task4", "Dinner")
      a_task4.setDueDate ("feb 16, 2018")
      a_tasklist.addTask a_task1
      a_tasklist.addTask a_task2
      a_tasklist.addTask a_task3
      a_tasklist.addTask a_task4
      expect(a_tasklist.incompleteTasksDueToday.length).to be 1
    end

    it "can sort incomplete tasks by duedate" do
      a_tasklist = TaskList.new
      a_task1 = Duedate.new("Task1", "Go for a run")
      a_task1.setDueDate ("feb 15, 2018")
      a_task2 = Duedate.new("Task2", "Eat brkfst")
      a_task2.done
      a_task2.setDueDate ("feb 15, 2018")
      a_task3 = Duedate.new("Task3", "School")
      a_task3.setDueDate ("feb 14, 2018")
      a_task4 = Duedate.new("Task4", "Dinner")
      a_task4.setDueDate ("feb 16, 2018")
      a_tasklist.addTask a_task1
      a_tasklist.addTask a_task2
      a_tasklist.addTask a_task3
      a_tasklist.addTask a_task4
      a_tasklist.sortedIncompleteTasks
      expect(a_tasklist.showSort).to eq [a_task3, a_task1, a_task4]
    end

    it "can sort tasks by duedate" do
      a_tasklist = TaskList.new
      a_task1 = Task.new("Task1", "Go for a run")
      a_task2 = Duedate.new("Task2", "Eat brkfst")
      a_task2.setDueDate ("feb 15, 2018")
      a_task3 = Duedate.new("Task3", "School")
      a_task3.setDueDate ("feb 14, 2018")
      a_task4 = Duedate.new("Task4", "Dinner")
      a_task4.setDueDate ("feb 16, 2018")
      a_tasklist.addTask a_task1
      a_tasklist.addTask a_task2
      a_tasklist.addTask a_task3
      a_tasklist.addTask a_task4
      a_tasklist.separateTasks
      a_tasklist.duetasksort
      expect(a_tasklist.showFinalSort).to eq [a_task3, a_task2, a_task4, a_task1]
    end

    it "anniversary er year" do
      a_tasklist = TaskList.new
      a_task1 = Duedate.new("Task1", "Go for a run")
      a_task1.anniversary("March 15")
      a_tasklist.addTask a_task1
      expect(a_task1.showAnniversary).to be_a Date
    end

    it "anniversary sets correct due date" do
      a_task1 = Duedate.new("Birthday", "Get presents!")
      a_task1.anniversary("March 15")
      p a_task1.showAnniversary
      a_task1.setDDforAnn
      p a_task1.showDueDate
      expect(a_task1.showDueDate).to eq(Date.parse("2018-03-15"))
    end

    it "anniversary sets correct due date (next year)" do
      a_task1 = Duedate.new("Birthday", "Eat cake!")
      a_task1.anniversary("January 15")
      p a_task1.showAnniversary
      a_task1.setDDforAnn
      p a_task1.showDueDate
      expect(a_task1.showDueDate).to eq(Date.parse("2019-01-15"))
    end

    it "can sort tasks by multiple kinds of duedate" do
      a_tasklist = TaskList.new
      a_task1 = Duedate.new("Task1", "Go for a run")
      a_task1.setDueDate ("April 20, 2018")
      a_task2 = Task.new("Task2", "Eat brkfst")
      a_task3 = Duedate.new("Task3", "School")
      a_task3.anniversary ("March 15")
      a_task3.setDDforAnn
      a_task4 = Duedate.new("Task4", "Dinner")
      a_task4.setDueDate ("March 1, 2018")
      a_tasklist.addTask a_task1
      a_tasklist.addTask a_task2
      a_tasklist.addTask a_task3
      a_tasklist.addTask a_task4
      a_tasklist.separateTasks
      a_tasklist.duetasksort
      expect(a_tasklist.showFinalSort).to eq [a_task4, a_task3, a_task1, a_task2]
    end
  end
