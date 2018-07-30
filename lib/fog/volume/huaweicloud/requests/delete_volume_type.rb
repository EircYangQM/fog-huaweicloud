module Fog
  module Volume
    class HuaweiCloud
      module Real
        def delete_volume_type(volume_type_id)
          request(
            :expects => 202,
            :method  => 'DELETE',
            :path    => "types/#{volume_type_id}"
          )
        end
      end

      module Mock
        def delete_volume_type(_volume_type_id)
          response = Excon::Response.new
          response.status = 204
          response
        end
      end
    end
  end
end
