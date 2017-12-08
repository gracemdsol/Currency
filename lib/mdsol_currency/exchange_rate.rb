class MdsolCurrency
  class ExchangeRate
    include MdsolCurrency::Remote

    attr_reader :build_tag

    def initialize(build_tag)
      # raise error - invalid build tag
      @build_tag = build_tag
    end

    def find_exchange_rate(currency_uuid:)
      currency = MdsolCurrency::Currency.new(currency_uuid)
      currency.exchange_rate(build_tag: self.build_tag)
    end

    def exchange_rate(location_uuid: nil, from_currency_uuid: nil, to_currency_uuid:)
      # raise error if neither location_uuid nor from_currency_uuid is not provided
      from_currency_uuid ||= MdsolCurrency::Location.new(location_uuid).default_currency_uuid
      from_currency = MdsolCurrency::Currency.new(from_currency_uuid)
      to_currency = MdsolCurrency::Currency.new(to_currency_uuid)
      return 1 if default_currency_uuid == currency_uuid
      (find_exchange_rate(currency_uuid: to_currency.uuid) /
          find_exchange_rate(currency_uuid: from_currency.uuid)).round(4) # precision
    end
  end
end
