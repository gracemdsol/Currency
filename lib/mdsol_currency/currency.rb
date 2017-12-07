class MdsolCurrency
  class Currency
    include MdsolCurrency::Remote

    class << self
      def all
        @all ||= currencies
                     .map(&:attributes)
                     .select { |currency| viewable_currency_uuids.include?(currency[:uuid]) }
      end


      private
      def currencies
        @currencies ||= remote_currencies
      end

      def location_defaults
        @location_defaults ||= remote_location_defaults
      end
    end

    attr_reader :uuid, :name, :code, :symbol

    def initialize(uuid)
      data = currencies.find { |currency| currency[:uuid] == uuid }
      # raise error - not found
      @uuid = data[:uuid]
      @name = data[:name]
      @code = data[:code]
      @symbol = data[:symbol]
    end

    def exchange_rate(build_tag:)
      @exchange_rate ||= remote_exchange_rates(build_tag: build_tag)
                             .find { |obj| obj.currency_uuid == self.uuid }
                             .try(:exchange_rate)
    end
  end
end
