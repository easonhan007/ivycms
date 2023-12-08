class DaisyFormBuilder < ActionView::Helpers::FormBuilder
  delegate :tag, :safe_join, to: :@template

  def input(method, options = {})
    @form_options = options
    object_type = object_type_for_method(method)

    input_type = case object_type
    when :date then :string
    when :integer then :string
    else object_type
    end

    override_input_type = if options[:as]
      options[:as]
    elsif options[:collection]
      :select
    end

    send("#{override_input_type || input_type}_input", method, options)
  end

  private

  def form_group(method, options = {}, &block)
    tag.div class: "my-5 flex justify-start items-baseline #{method}" do
      safe_join [
        block.call,
        hint_text(options[:hint]),
        error_text(method),
      ].compact
    end
  end

  def hint_text(text)
    return if text.nil?
    tag.small text, class: "text-sm text-gray-600 p-4 hidden lg:block"
  end

  def error_text(method)
    return unless has_error?(method)

    tag.div(@object.errors[method].join("<br />").html_safe, class: "text-sm text-red-500 p-4 hidden lg:block")
  end

  def object_type_for_method(method)
    result = if @object.respond_to?(:type_for_attribute) && @object.has_attribute?(method)
      @object.type_for_attribute(method.to_s).try(:type)
    elsif @object.respond_to?(:column_for_attribute) && @object.has_attribute?(method)
      @object.column_for_attribute(method).try(:type)
    end

    result || :string
  end

  def has_error?(method)
    return false unless @object.respond_to?(:errors)
    @object.errors.key?(method)
  end

	def size_string
		"w-full max-w-sm"
	end

	def label_size_string
		'w-1/5'
	end

  # Inputs and helpers

  def string_input(method, options = {})
    form_group(method, options) do
      safe_join [
        (label(method, options[:label], class: label_size_string) unless options[:label] == false),
        string_field(method, merge_input_options({class: "input input-sm input-bordered #{size_string} #{"input-error" if has_error?(method)}"}, options[:input_html])),
      ]
    end
  end

  def text_input(method, options = {})
    form_group(method, options) do
      safe_join [
        (label(method, options[:label], class: label_size_string) unless options[:label] == false),
        text_area(method, merge_input_options({class: "textarea  textarea-bordered textarea-sm #{size_string} #{"textarea-error" if has_error?(method)}"}, options[:input_html])),
      ]
    end
  end

  def boolean_input(method, options = {})
    form_group(method, options) do
      # tag.div(class: "custom-control custom-checkbox") do
        safe_join [
          label(method, options[:label], class: label_size_string),
          check_box(method, merge_input_options({class: "checkbox"}, options[:input_html])),
        ]
      # end
    end
  end

  def collection_input(method, options, &block)
    form_group(method, options) do
      safe_join [
        label(method, options[:label], class: label_size_string),
        block.call,
      ]
    end
  end

  def select_input(method, options = {})
    value_method = options[:value_method] || :to_s
    text_method = options[:text_method] || :to_s
    input_options = options[:input_html] || {}

    multiple = input_options[:multiple]

    collection_input(method, options) do
      collection_select(method, 
        options[:collection], 
        value_method, 
        text_method, 
        options, merge_input_options({class: "#{"select select-bordered select-sm" unless multiple} #{size_string} #{"select-error" if has_error?(method)}"}, 
        options[:input_html]))
    end
  end

  def grouped_select_input(method, options = {})
    # We probably need to go back later and adjust this for more customization
    collection_input(method, options) do
      grouped_collection_select(method, options[:collection], :last, :first, :to_s, :to_s, options, merge_input_options({class: "custom-select form-control #{"is-invalid" if has_error?(method)}"}, options[:input_html]))
    end
  end

  def file_input(method, options = {})
    form_group(method, options) do
      safe_join [
        (label(method, options[:label], class: label_size_string) unless options[:label] == false),
        # custom_file_field(method, options),
        file_field(method, options.merge(class: "file-input file-input-sm file-input-bordered #{size_string}")),
      ]
    end
  end

  def collection_of(input_type, method, options = {})
    form_builder_method, custom_class, input_builder_method = case input_type
    when :radio_buttons then [:collection_radio_buttons, "custom-radio", :radio_button]
    when :check_boxes then [:collection_check_boxes, "custom-checkbox", :check_box]
    else raise "Invalid input_type for collection_of, valid input_types are \":radio_buttons\", \":check_boxes\""
    end

    form_group(method, options) do
      safe_join [
        label(method, options[:label]),
        tag.br,
        (send(form_builder_method, method, options[:collection], options[:value_method], options[:text_method]) do |b|
          tag.div(class: "custom-control #{custom_class}") {
            safe_join [
              b.send(input_builder_method, class: "custom-control-input"),
              b.label(class: "custom-control-label"),
            ]
          }
        end),
      ]
    end
  end

  def radio_buttons_input(method, options = {})
    collection_of(:radio_buttons, method, options)
  end

  def check_boxes_input(method, options = {})
    collection_of(:check_boxes, method, options)
  end

  def string_field(method, options = {})
    case object_type_for_method(method)
    when :date then
      birthday = method.to_s =~ /birth/
      safe_join [
        date_field(method, merge_input_options(options, {data: {datepicker: true}})),
        tag.div {
          date_select(method, {
            order: [:month, :day, :year],
            start_year: birthday ? 1900 : Date.today.year - 5,
            end_year: birthday ? Date.today.year : Date.today.year + 5,
          }, {data: {date_select: true}})
        },
      ]
    when :integer then number_field(method, options)
    when :string
      case method.to_s
      when /password/ then password_field(method, options)
      # when /time_zone/ then :time_zone
      # when /country/   then :country
      when /email/ then email_field(method, options)
      when /phone/ then telephone_field(method, options)
      when /url/ then url_field(method, options)
      else
        text_field(method, options)
      end
    end
  end

  def custom_file_field(method, options = {})
    tag.div(class: "input-group") {
      safe_join [
        tag.div(class: "input-group-prepend") {
          tag.span("Upload", class: "input-group-text")
        },
        tag.div(class: "custom-file") {
          safe_join [
            file_field(method, options.merge(class: "custom-file-input", data: {controller: "file-input"})),
            label(method, "Choose file...", class: "custom-file-label"),
          ]
        },
      ]
    }
  end

  def merge_input_options(options, user_options)
    return options if user_options.nil?

    # TODO handle class merging here
    options.merge(user_options)
  end
end