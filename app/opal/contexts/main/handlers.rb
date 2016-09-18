Ruta::Handlers.define_for :main_layout do
  # handle :search_bar do |params,url|
  #   
  # end
  #
  # handle :comics do |params,url|
  #   
  # end
end

# Ruta::Handlers.define_for :landing do
#   sub_contexts = %w{about gallery syllabus}
#   handle :action_bar do |params,url|
#     par = params.fetch(:sub_context) {:about}
#     if sub_contexts.include? par
#       Components::Landing::Action_Bar current_section: par
#     else
#       default
#     end
#   end
#
#   handle :view_port do |params,url|
#     par = params.fetch(:sub_context) {:about}
#     if sub_contexts.include? par
#       mount par
#     else
#       default
#     end
#   end
# end
