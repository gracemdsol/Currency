class MdsolCurrency
  class Location
    include MdsolCurrency::Remote

    class << self
      def all
        @all ||= references_countries.select { |country| location_defaults[country[:uuid]][:is_mdsol_viewable] }
      end

      private
      def countries
        @countries ||= remote_countries.map { |obj| obj.attributes.with_indifferent_access }
        # .map(&:attributes)
        # .each_with_object({}) { |obj, hash| hash[obj['uuid']]= obj.with_indifferent_access }
      end

      def location_defaults
        @location_defaults ||= remote_location_defaults
                                   .map(&:attributes)
                                   .each_with_object({}) do |obj, hash|
          country_uuid = obj.uri.split(':').last # mdsol_tools? parse
          hash[country_uuid]= obj.with_indifferent_access
        end
      end
    end

    attr_reader :uuid, :name, :code, :default_currency_uuid

    def initialize(uuid)
      data = countries.find { |country| country[:uuid] == uuid }
      # raise error - not found
      @uuid = data[:uuid]
      @name = data[:name]
      @code = data[:three_letter_code]
    end
  end
end
