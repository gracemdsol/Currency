class MdsolCurrency
  class Currency
    class << self
      def all
        @all ||= Remote::currencies.select { |currency| Remote::viewable_currency_uuids.include?(currency.uuid) }
      end
    end

    attr_reader :uuid, :name, :code, :symbol

    def initialize(uuid)
      raise ArgumentError, 'Invalid currency uuid' unless Remote::viewable_currency_uuids.include?(uuid)
      data = Remote::currencies.find { |currency| currency[:uuid] == uuid }
      @uuid = data[:uuid]
      @name = data[:name]
      @code = data[:code]
      @symbol = data[:symbol]
    end

    def exchange_rate(build_tag:)
      @exchange_rate ||= Remote::exchange_rates(build_tag: build_tag)
                             .find { |obj| obj.currency_uuid == self.uuid }
                             .exchange_rate
    end
  end
end
