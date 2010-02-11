require 'json'

class Messiah::Supports::CodeIgniter
  attr_accessor :config

  def initialize(config)
    @config = config
    configure!
    configure_database!
  end

  def configure!
    config.script 'index.php'
    config.database_file File.join(config.app_root, 'config', 'database.php')
  end

  def configure_database!
    reader = File.join(File.dirname(__FILE__), 'code_igniter.php')
    json = %x|php #{reader} #{config.database_file}|
    ci_hash = JSON.load(json)

    config.database = {
      :adapter    => ci_hash['dbdriver'],
      :host       => ci_hash['hostname'],
      :database   => ci_hash['database'],
      :port       => ci_hash['port'] && ci_hash['port'].to_i,
      :username   => ci_hash['username'],
      :password   => ci_hash['password']
    }
  rescue
    # swallow everything, leave the database unconfigured
  end
end
