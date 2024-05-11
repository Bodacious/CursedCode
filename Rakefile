require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "acme"
  t.test_files = FileList["test/**/*_test.rb"]
end

task default: %i[test]

# desc "Run the acme.rb file and see if it works!"
# task :run do
#   load("./acme.rb")
# end
