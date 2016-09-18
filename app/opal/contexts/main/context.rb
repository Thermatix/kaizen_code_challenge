Ruta::Context.define :main_layout do
  component :top do
    Components::Layout::Top
  end

  sub_context :view,:input_view

  component :Bottom do
    Components::Layout::Bottom
  end
end

Ruta::Context.define :input_view do
  component :form do
    Components::Input::Form
  end
end
