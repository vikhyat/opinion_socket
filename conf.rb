require 'yaml'

class Configuration
  def self.[](key)
    @@conf ||= YAML.load(File.read 'conf.yaml')
    @@conf[key.to_s]
  end
end
