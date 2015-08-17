module SearchPlace

  class Search9Flats

    include HTTParty
    base_uri "https://api.9flats.com"

    def initialize
      @options = { 'client_id' => APP_ENV['9flats_key'] }
    end

    def get_photos_of(place)
      res = http_get_photos_of(place)
      photo_urls = map_photo_urls(res)
    end

    private

    def http_get_photos_of(place)
      @options['search[query]'] = place
      @options['search[page]'] = 1 # TODO: add pagination!
      res = self.class.get "/api/v4/places", query: @options
      res
    end

    # Output: { id1 => { url1 => 0, url1 => 1, ... }, id2 => ... }
    def map_photo_urls(res)
      photos = {}
      res['places'].each do |raw_place|
        place = raw_place['place']['place_details']
        place_id = place['id']
        photos[place_id] ||= {}
        photos[place_id][place['featured_photo']['medium']] = 0
        place['additional_photos'].each do |photo|
          photos[place_id][photo['place_photo']['url']] = 0
        end
      end
      photos
    end

  end

end
