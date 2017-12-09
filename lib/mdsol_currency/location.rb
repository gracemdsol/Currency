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
      raise ArgumentError, 'Invalid location uuid' unless viewable_country_uuids.include?(uuid)
      country = remote_countries.find { |country| country.uuid == uuid }
      default = remote_location_defaults.find{ |default| default.uri == 'com:mdsol:countries:'.concat(uuid) }
      @uuid = country.uuid
      @name = country.name
      @code = country.three_letter_code
      @default_currency_uuid = default.default_currency_uuid
    end
  end
end
