module Components
  module Comics
    class View < Base

      param search_terms: {}

      define_state comics: []

      before_mount do
        api_request :get , "comics#{paramaterize(params.search_terms)}" do |results|
          state.comics! results
        end
      end

      def render
        div(class: "comics_view") do
          state.comics.each do |comic|
#           {"id"=>42882, "digitalId"=>26110, "title"=>"Lorna the Jungle Girl (1954) #6", "description"=>nil, "page_url"=>{"type"=>"detail", "url"=>"http://marvel.com/comics/issue/42882/lorna_the_jungle_girl_1954_6?utm_campaign=apiRef&utm_source=b9464352a3f6b66f2a59ab4e106b70f7"}, "image"=>"http://i.annihil.us/u/prod/marvel/i/mg/9/40/50b4fc783d30f.jpg"}  
            div(class: "comic") do
              img(src: comic['image'])
            end
          end
        end
      end

    end
  end
end
