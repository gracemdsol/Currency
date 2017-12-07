class MdsolCurrency
  class ExchangeRate
    class << self

      def find_exchange_rate(currency_uuid)
        exchange_rates.find { |rate| rate.currency_uuid == currency_uuid }.exchange_rate
        # not found?
      end

      def exchange_rate(location_uuid:, currency_uuid:, build_tag:)
        default_currency_uuid = location_defaults.find { |obj| obj.uuid = location_uuid }.default_currency_uuid
        return 1 if default_currency_uuid == currency_uuid
        (find_exchange_rate(currency_uuid) / find_exchange_rate(default_currency_uuid)).round(4) # precision
      end

      private

      def location_defaults
        @location_defaults ||= Euresource::LocationDefault.get(:all)
      end

      def exchange_rates
        @exchange_rates ||= Euresource::ExchangeRate.get(:all, params: {build_tag: 65}, method: :index)
      end
    end
  end
end
