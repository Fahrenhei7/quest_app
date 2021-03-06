class ArrayInput < SimpleForm::Inputs::StringInput

  def input(wrapper_options = nil)
    input_html_options[:type] ||= input_type

    existing_values = Array(object.public_send(attribute_name)).map do |array_el|
      form(array_el)
    end

    existing_values.push form(nil) if existing_values.length < 1
    existing_values.join.html_safe
  end

  def form(value)
    @builder.text_field(nil, input_html_options.merge( class: 'form-control single-key', value: value, name: "#{object_name}[#{attribute_name}][]"))
  end

  def input_type
    :text
  end
end
