module ActionView::Helpers
  class FormBuilder

    def inputs(options = {}, &block)
      update_options_with_class(options, 'form-inputs')
      @template.content_tag(:section, options) { yield }
    end

    def actions(options = {}, &block)
      update_options_with_class!(options, 'form-actions')
      @template.content_tag(:section, options) { yield }
    end

    protected

    def update_options_with_class!(options, klass)
      options[:class] ||= ''
      options[:class] << " #{klass}"
      options
    end

  end
end