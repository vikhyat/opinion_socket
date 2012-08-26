require 'yaml'

task :new_poll, :title do |t, args|
  # Get the filename by downcasing and replacing whitespace with _s.
  filename = args[:title].downcase.gsub(/\s+/, '_') + '.yaml'

  # Make sure we have a unique filename.
  if File.exist?("polls/#{filename}")
    raise("A poll already exists with the given name. You should either delete the previous poll or change the name of the current poll.")
  end

  # Create the initial YAML, and write it to the new file.
  poll = {
    'title' => args[:title],
    'description' => "",
    'form' => ""
  }.to_yaml
  File.open("polls/#{filename}", 'w') {|f| f.puts poll }

  # Print a message telling the user to edit the file just created.
  puts "Created a new poll: polls/#{filename}."
  puts "You need to edit the file to add the description and form HTML."
end
