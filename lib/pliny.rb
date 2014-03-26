abort("Missing DATABASE_URL") unless ENV["DATABASE_URL"]

module Pliny
  # Requires an entire directory of source files in a stable way so that file
  # hierarchy is respected for load order.
  def self.require_relative_glob(relative_path)
    files = Dir["#{Pliny.root}/lib/pliny/#{relative_path}"].sort_by do |file|
      [file.count("/"), file]
    end

    files.each do |file|
      require file
    end
  end

  def self.root
    @@root ||= File.expand_path("../../", __FILE__)
  end
end

require_relative "pliny/endpoints/base"

Pliny.require_relative_glob("pliny/endpoints/**/*.rb")

require_relative "pliny/main"