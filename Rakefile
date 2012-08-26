require 'yaml'
require 'csv'
require './lib/token.rb'
require './lib/email.rb'

def filename_from_title(title)
  title.downcase.gsub(/\s+/, '_') + '.yaml'
end

desc "create a new poll"
task :new_poll, :title do |t, args|
  # Get the filename by downcasing and replacing whitespace with _s.
  filename = filename_from_title(args[:title])

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


desc "send emails to all students to vote for a particular poll"
task :send_emails, :title do |t, args|
  filename = filename_from_title(args[:title])
  base_url = Configuration[:base_url]

  # First, make sure the title is valid.
  unless File.exist?("polls/#{filename}")
    raise "Invalid poll title."
  end

  # Get a list of the enrollment numbers.
  enrollments = YAML.load(File.read 'enrollments.yaml')
  
  # Send out the emails.
  enrollments.each do |enrollment|
    send_email(enrollment+"@students.iitmandi.ac.in",
               args[:title],
               "Hi,

Please fill out your opinions regarding #{args[:title]} by opening the
following link:

#{base_url}/#{filename[0..-6]}/#{token(enrollment, filename)}/#{enrollment}

Thank you for your cooperation.")
  end
end

desc "generate the CSV files for all polls"
task :generate_csv do
  polls = Dir.glob("results/*").map {|x| x.split('/')[-1] }
  polls.each do |poll|
    results = {}
    filtered_results = {}
    voted = Dir.glob("results/#{poll}/*").map {|x| x.split('/')[-1] }
    voted.each do |voter|
      res = YAML.load(File.read "results/#{poll}/#{voter}")
      keys = res.keys
      keys -= ["filename", "token", "submit", "splat",
               "captures", "filename_url"]
      results[voter] = {}
      keys.each do |key|
        results[voter][key] = res[key]
      end
    end

    headers = results.map {|k,v| v.keys }.flatten.uniq

    csv = CSV.generate do |csv|
      csv << headers
      results.each do |enrl, res|
        a = []
        headers.each {|h| a << res[h] }
        csv << a
      end
    end

    File.open("results/#{poll}.csv", 'w') {|f| f.puts csv }
  end
end
