class MissedConnections::Post

  @@all = []

  attr_accessor :title, :url, :content

  # Use .send, mass assignment, interpolate the value of "k", set it equal to "v"
  def initialize(missed_connections_hash)
    missed_connections_hash.each {|k,v| self.send("#{k}=",v)}
    @@all << self
  end

  def self.create_from_collection(missed_connections_array)
    missed_connections_array.each {|missed_connections_hash| self.new(missed_connections_hash)}
  end

  def self.create_individual_post(content_hash)
    individual_post = self.new(content_hash)
  end

  def self.all
    @@all
  end
end
