module ApplicationHelper
  def options_for_enum(model_class, enum)
    enum_hash = model_class.send(enum.to_s.pluralize)

    enum_hash.map do |key, value|
      [model_class.human_attribute_name("#{enum}.#{key}"), value]
    end
  end
end
