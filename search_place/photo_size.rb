module SearchPlace

  class PhotoSize

    def initialize(threadPool)
      @threadPool = threadPool
    end

    def calculate(photo_list)
      photo_list.each do |place_id, batch|
        get_photo_sizes_in_batch(photo_list, place_id)
      end

      finalize_requests(photo_list)
      sort_photo_list(photo_list)
    end

    def get_photo_sizes_in_batch(photo_list, place_id)
      photo_list[place_id].each do |url, _|
        photo_list[place_id][url] = (Concurrent::Future.new executor: @threadPool do
          get_photo_size(url)
        end).execute
      end
    end

    def get_photo_size(url)
      begin
        `curl -I http:#{url}`.split("\r\n").find { |el| el =~ /^Content-Length/ }.split(': ')[1].to_i
      rescue
        nil
      end
    end

    private

    def finalize_requests(photo_list)
      photo_list.each do |place_id, batch|
        batch.each do |url, _|
          photo_list[place_id][url] = photo_list[place_id][url].value
        end
      end
    end

    def sort_photo_list(photo_list)
      photo_list.each do |place_id, batch|
        photo_list[place_id] = Hash[photo_list[place_id].sort_by { |url, photo_size| photo_size }]
      end

      photo_list
    end

  end

end
