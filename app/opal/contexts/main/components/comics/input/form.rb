module Components
  module Input
    class  Form < Base
      define_state data: {}
      define_state display: :input
      define_state results: nil
      def render
        div class: "main" do
          h3 {"Discover When You Would Have Won The Lottery And How Much You Would Have Won"}
          dashed_line
          case state.display
          when :input
            handle :submit do
              form(action: "/api/winner",method: "post") do
                label(html_for: "numbers") {"Enter your Lucky Numbers"}
                handle :change, :numbers do
                  input(id: "numbers",type: "text", max_length: 17)
                end
                label(html_for: "bonus_number") {"Bonus"}
                handle :change, :bonus_number do
                  input(id: "bonus_number", type: "text", max_length: 2)
                end
                input(type: "submit",value: "submit")
              end
            end
          when :processing
            dashed_line
            h3 {"Your Lucky Numbers are"}
            h2 {state.data[:numbers]}
            dashed_line
            img(src: "/assets/images/spinner.gif")
          when :finished
            div do
              h3 {"Your Lucky Numbers are"}
              h2 {state.data[:numbers]}
            end
            div do
              h3{"Bonus Number"}
              h2 {state.data[:bonus_number]}
            end
            dashed_line
            h3 {"Results"}
            if state.results[:success]
              img(src: "/assets/images/yes.png")
              p {"you would have won"}
              div{state.results[:total]}
              table do
                tr do
                  th {"Date"}
                  th {"Amount"}
                end
                state.results[:results].each do |res|
                  tr do
                    td {res[:date]}
                    td {res[:jackpot]}
                  end
                end
              end
            else
              img(src: "/assets/images/no.png")
              p {state.results[:message]}
            end
          end
        end
      end

      def dashed_line
        img(src: "/assets/images/dashed-lines.png")
      end

      def handle_submit event
        event.prevent_default
        state.display! :processing
        post_winner state.data.to_json do |response|
          state.results! response
          state.display! :finished
        end
      end

      def handle_change event,state_key
        state.data! state.data.merge(state_key => event.target.value)
      end

    end
  end
end
