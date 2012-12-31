require "bundler/gem_tasks"

require 'guard/jasmine/task'

Guard::JasmineTask.new('jasmine:specs') do |task|
  task.options = "-s thin -p 3001"
end

Guard::JasmineTask.new('jasmine:stories') do |task|
  task.options = "-s thin -p 3001 -u http://localhost:3001/jasmine-stories"
end

task 'jasmine:all' => ['guard:jasmine:specs', 'guard:jasmine:stories']
