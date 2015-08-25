class BooleanInput < SimpleForm::Inputs::BooleanInput

  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    if nested_boolean_style?
      build_hidden_field_for_checkbox +
        template.label_tag(nil, class: SimpleForm.boolean_label_class) {
          build_check_box_without_hidden_field(merged_input_options) +
            custom_checkbox_span + span_label
        }
    else
      build_check_box(unchecked_value, merged_input_options)
    end
  end

  def label_input(wrapper_options = nil)
    if options[:label] == false || inline_label?
      input(wrapper_options)
    elsif nested_boolean_style?
      html_options = label_html_options.dup
      html_options[:class] ||= []
      html_options[:class].push(SimpleForm.boolean_label_class) if SimpleForm.boolean_label_class

      merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

      build_hidden_field_for_checkbox +
        @builder.label(label_target, html_options) {
          build_check_box_without_hidden_field(merged_input_options) +
            custom_checkbox_span + wrapped_label_text
        }
    else
      input(wrapper_options) + label(wrapper_options)
    end
  end

  private

  def custom_checkbox_span
    content_tag(:span, nil, class: 'control-indicator icon').html_safe
  end

  def span_label
    content_tag(:span, inline_label, class: 'label-text').html_safe if inline_label
  end

  def wrapped_label_text
    content_tag(:span, label_text, class: 'label-text').html_safe
  end

end
