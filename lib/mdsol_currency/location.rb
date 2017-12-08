class MdsolCurrency
  class Location
    include MdsolCurrency::Remote

    class << self
      def all
        @all ||= remote_countries.select { |country| viewable_country_uuids.include?(country.uuid) }
      end
    end

    attr_reader :uuid, :name, :code, :default_currency_uuid

    def initialize(uuid)
      data = remote_countries.find { |country| country.uri == 'com:mdsol:countries:'.concat(uuid) }
      # raise error - not found
      @uuid = data.uuid
      @name = data.name
      @code = data.three_letter_code
      @default_currency_uuid = data.default_currency_uuid
    end
  end
end
