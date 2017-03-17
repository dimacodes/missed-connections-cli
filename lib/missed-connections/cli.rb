# CLI Controller
class MissedConnections::CLI

  def call
    greeting
    create_title
    list_title
    menu
    goodbye
  end

  def greeting
    puts ""
    puts "A missed connection is a type of personal advertisement on craigslist.org which is usually written after two people meet but are unable to exchange contact details."
    puts ""
    puts "Finding today's missed connections in New York City..."
    puts ""
    puts "Please wait..."
    puts ""
  end

  def create_title
    post_array = MissedConnections::Scraper.scrape_title_page
    MissedConnections::Post.create_from_collection(post_array)
  end

  def list_title
    MissedConnections::Post.all.each_with_index do |post, i|
      puts "#{i + 1}. #{self.censor(post.title)}"
    end
  end

  def menu
    @input = nil
    while @input != "exit"
      puts ""
      puts "Please type the number of the missed connection you'd like to see (1-100), or 'list', or 'exit' and press 'enter':"
      puts ""
      @input = gets.strip.downcase
      if @input.to_i > 0
        puts ""
        create_post
        read_post
      elsif @input == "list"
        puts ""
        list_title
      elsif @input == "exit"
        puts ""
      else
        puts ""
        puts "Not sure what you want, please type 1-100, 'list', or 'exit' and press 'enter':"
      end
    end
  end

  def censor(words)
    words.split(" ").map do |word|
    WORDS_TO_CENSOR.find{|word_to_censor| word.downcase.match(word_to_censor)} ? '*' * word.length : word
    end.join(" ")
  end

  def create_post
    index = @input.to_i - 1
    post_url = MissedConnections::Post.all[index].url
    content_hash = MissedConnections::Scraper.scrape_post_page(post_url)
    post = MissedConnections::Post.create_individual_post(content_hash)
    post.content
  end

  def read_post
    index = @input.to_i - 1
    post = MissedConnections::Post.all[index]
    puts self.censor(create_post)
  end

  def goodbye
    puts "Don't be a stranger!"
    puts ""
  end
end
