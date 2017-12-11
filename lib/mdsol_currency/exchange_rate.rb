class MdsolCurrency
  class ExchangeRate
    attr_reader :build_tag

    PRECISION = 4

    def initialize(build_tag)
      raise ArgumentError, 'Invalid build tag' if build_tag > Remote::latest_build_tag
      @build_tag = build_tag
    end

    def find_exchange_rate(currency_uuid:)
      currency = MdsolCurrency::Currency.new(currency_uuid)
      currency.exchange_rate(build_tag: self.build_tag)
    end

    def exchange_rate(location_uuid: nil, from_currency_uuid: nil, to_currency_uuid:)
      raise ArgumentError, 'Please provide location_uuid or from_currency_uuid' if location_uuid.nil? and from_currency_uuid.nil?
      from_currency_uuid ||= MdsolCurrency::Location.new(location_uuid).default_currency_uuid
      return 1 if from_currency_uuid == to_currency_uuid
      from_currency = MdsolCurrency::Currency.new(from_currency_uuid)
      to_currency = MdsolCurrency::Currency.new(to_currency_uuid)
      (find_exchange_rate(currency_uuid: to_currency.uuid) /
          find_exchange_rate(currency_uuid: from_currency.uuid)).round(PRECISION)
    end
  end
end
