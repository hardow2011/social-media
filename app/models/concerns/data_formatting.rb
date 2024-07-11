module DataFormatting
  extend ActiveSupport::Concern

  included do
    private
      def strip_whitespace(*attr_names)
        attr_names.each do |attr_name|
          send("#{attr_name.to_s}=", self[attr_name].strip)
        end
      end
  end

end
