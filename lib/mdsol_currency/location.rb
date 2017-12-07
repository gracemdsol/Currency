class MdsolCurrency
  class Location
    class << self
      def all
        @all ||= references_countries.select { |country| location_defaults[country[:uuid]][:is_mdsol_viewable] }
      end

      private
      def references_countries
        @references_countries ||= Euresource::Country.get(:all, params: {per_page: 300})
                                      .map { |obj| obj.attributes.with_indifferent_access }
        # .map(&:attributes)
        # .each_with_object({}) { |obj, hash| hash[obj['uuid']]= obj.with_indifferent_access }
      end

      def location_defaults
        @location_defaults ||= Euresource::LocationDefault.get(:all)
                                   .map(&:attributes)
                                   .each_with_object({}) do |obj, hash|
          country_uuid = obj.uri.split(':').last  # mdsol_tools? parse
          hash[country_uuid]= obj.with_indifferent_access
        end
      end
    end

    attr_reader :uuid, :name, :three_letter_code

    def initialize(uuid)
      data = references_countries.select{|country| country[:uuid] == uuid}.first
      # raise error - not found
      @uuid = data[:uuid]
      @name = data[:name]
      @three_letter_code = data[:three_letter_code]
    end
  end
end
