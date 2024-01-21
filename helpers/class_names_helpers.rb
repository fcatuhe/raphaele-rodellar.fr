# Inspired by https://github.com/rails/rails/pull/37918
module ClassNamesHelpers
  def class_names(*args)
    safe_join(build_tag_values(*args), " ")
  end

  private

    def safe_join(array, sep = $,)
      sep = ERB::Util.unwrapped_html_escape(sep)

      array.flatten.map! { |i| ERB::Util.unwrapped_html_escape(i) }.join(sep).html_safe
    end

    def build_tag_values(*args)
      tag_values = []

      args.each do |tag_value|
        case tag_value
        when Hash
          tag_value.each do |key, val|
            tag_values << key if val
          end
        when Array
          tag_values << build_tag_values(*tag_value).presence
        else
          tag_values << tag_value.to_s if tag_value.present?
        end
      end

      tag_values.compact.flatten
    end
end
