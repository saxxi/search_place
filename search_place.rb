require 'ap'
require 'pry'

require 'yaml'
require 'httparty'
require 'net/http'
require 'concurrent'
require 'thread'   # for Queue

require './search_place/search9flats'
require './search_place/photo_size'

module SearchPlace
  APP_ENV = YAML.load_file('./env.yml') # File content: `9flats_key: 'XXXXXXX'`
end

photo_list = {
  8779 => {
     "//images.9flats.com/place_photos/photos/62173-1423332758/medium.jpg" => 0,
     "//images.9flats.com/place_photos/photos/62175-1423332780/medium.jpg" => 0,
    "//images.9flats.com/place_photos/photos/254867-1329067972/medium.jpg" => 0
  },
  124267 => {
    "//images.9flats.com/place_photos/photos/3216779-1391437243/medium.jpeg" => 0,
    "//images.9flats.com/place_photos/photos/3216780-1391437253/medium.jpeg" => 0,
    "//images.9flats.com/place_photos/photos/3216781-1391437264/medium.jpeg" => 0,
    "//images.9flats.com/place_photos/photos/3216782-1391437275/medium.jpeg" => 0,
    "//images.9flats.com/place_photos/photos/3216783-1391437286/medium.jpeg" => 0,
    "//images.9flats.com/place_photos/photos/3216784-1391437296/medium.jpeg" => 0,
    "//images.9flats.com/place_photos/photos/3216785-1391437307/medium.jpeg" => 0,
    "//images.9flats.com/place_photos/photos/3216786-1391437317/medium.jpeg" => 0,
    "//images.9flats.com/place_photos/photos/3216789-1391437328/medium.jpeg" => 0,
    "//images.9flats.com/place_photos/photos/3216795-1391437339/medium.jpeg" => 0,
    "//images.9flats.com/place_photos/photos/3216799-1391437350/medium.jpeg" => 0,
    "//images.9flats.com/place_photos/photos/3216804-1391437359/medium.jpeg" => 0,
    "//images.9flats.com/place_photos/photos/3216810-1391437369/medium.jpeg" => 0
  }
}

photo_list = SearchPlace::Search9Flats.new.get_photos_of("Hamburg")
ap photo_list
# ap SearchPlace::PhotoSize.new.calculate(photo_list)
