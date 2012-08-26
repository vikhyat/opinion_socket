require 'sinatra'
require 'yaml'
require_relative '../lib/token.rb'

get '/' do
  erb :index
end

get '/:filename/:token/:enrollment' do
  @enrollment = params[:enrollment]
  @token      = params[:token]
  @filename   = params[:filename]

  # First, make sure the poll is valid.
  if File.exist?("polls/#{@filename}.yaml")
    # If it is valid, load the details from the file.
    poll = YAML.load(File.read("polls/#{@filename}.yaml"))
    @title = poll['title']
    @description = poll['description']
    # Check whether the token is valid.
    if params[:token] == token(@enrollment, @filename + '.yaml')
      if not File.exist?("results/#{params[:filename]}/#{params[:enrollment]}")
        @form = poll['form']
        @submit = true
      else
        @form = "<p><em>You have already voted on this issue.</em></p>"
        @submit = false
      end
    else
      @form = "<p><em>Invalid access token.</em></p>"
      @submit = false
    end
  else
    @title = "Invalid URL."
    @description = ""
    @form = ""
    @submit = false
  end

  erb :issue
end

post '/:filename_url' do
  # Validations...
  valid = ! File.exist?("results/#{params[:filename]}/#{params[:enrollment]}")
  valid &&= params[:filename] == params[:filename_url]
  valid &&= params[:token] == token(params[:enrollment], 
                                    params[:filename] + '.yaml')

  if valid
    if not File.exist?("results/#{params[:filename]}")
      Dir.mkdir("results/#{params[:filename]}")
    end
    File.open("results/#{params[:filename]}/#{params[:enrollment]}",'w') do |f|
      f.puts params.to_yaml
    end
  end

  redirect "/#{params[:filename]}/#{params[:token]}/#{params[:enrollment]}"
end
