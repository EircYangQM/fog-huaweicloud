module Fog
  module Identity
    class HuaweiCloud
      class V3
        class Real
          def delete_project(id)
            request(
              :expects => [204],
              :method  => 'DELETE',
              :path    => "projects/#{id}"
            )
          end
        end

        class Mock
        end
      end
    end
  end
end
