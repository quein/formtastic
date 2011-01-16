require 'support/base'

module Formtastic
  module Inputs
    module BooleanInput
      include Support::Base
      
      # Outputs a label containing a checkbox and the label text. The label defaults
      # to the column name (method name) and can be altered with the :label option.
      # :checked_value and :unchecked_value options are also available.
      def boolean_input(method, options)
        html_options  = options.delete(:input_html) || {}
        checked_value = options.delete(:checked_value) || '1'
        unchecked_value = options.delete(:unchecked_value) || '0'
  
        html_options[:id] = html_options[:id] || generate_html_id(method, "")
        input = template.check_box_tag(
          "#{@object_name}[#{method}]",
          checked_value,
          (@object && @object.send(:"#{method}")),
          html_options
        )
        
        options = options_for_label(options)
        options[:for] ||= html_options[:id]
  
        # the label() method will insert this nested input into the label at the last minute
        options[:label_prefix_for_nested_input] = input
  
        template.hidden_field_tag("#{@object_name}[#{method}]", unchecked_value, :id => nil) << label(method, options)
      end
    end
  end
end