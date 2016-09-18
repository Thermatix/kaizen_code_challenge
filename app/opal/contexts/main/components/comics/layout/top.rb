module Components
  module Layout
    class  Top < Base

      def render
        div(class: "top_container") do
          img(class: "background_top",src: "/assets/images/background.png")
        end
      end

    end
  end
end


