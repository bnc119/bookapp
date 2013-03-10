require 'goodreads'

class GoodReads

  @client = Goodreads::Client.new(:api_key =>'48CscoZJ4dWudrtBiOlaqg',
                               :api_secret => '35BVnsO0JCY5XKsF1z8MMt2pM9u61gLPke2z0HB9OFo' )
  def self.search(query)

    results = []
    search = @client.search_books(query.to_s)

      if search.results.is_a? Hashie::Mash
        search.results.work.each do |book|
          
          results << book.best_book
        end
      end 
    
    
    return results
  end

end

