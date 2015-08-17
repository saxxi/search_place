require 'ap'

require 'yaml'
require 'httparty'
require 'net/http'
require 'concurrent'
require 'thread'

require './search_place/search9flats'
require './search_place/photo_size'

module SearchPlace
  APP_ENV = YAML.load_file('./env.yml') # File content: `9flats_key: 'XXXXXXX'`
end

threadPool = Concurrent::ThreadPoolExecutor.new(
  min_threads: [2, Concurrent.processor_count].min,
  max_threads: [2, Concurrent.processor_count].max,
  max_queue:   [2, Concurrent.processor_count].max * 5,
  overflow_policy: :caller_runs
)

photo_list = SearchPlace::Search9Flats.new(threadPool).get_photos_of("Hamburg")
ap SearchPlace::PhotoSize.new(threadPool).calculate(photo_list)
