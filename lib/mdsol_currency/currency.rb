class MdsolCurrency
  class Currency
    class << self
      def all
        @all ||= references_currencies
                     .map(&:attributes)
                     .select { |currency| viewable_currency_uuids.include?(currency[:uuid]) }
      end


      private
      def references_currencies
        @references_currencies ||= Euresource::Currency.get(:all, params: {per_page: 300}, method: :index)
      end

      def location_defaults
        @location_defaults ||= Euresource::LocationDefault.get(:all)
      end

      def viewable_currency_uuids
        @viewable_currencies ||= location_defaults.each_with_object([]) { |obj, arr| arr << obj.uuid if obj.is_mdsol_viewable }
      end

      # def exchange_rates
      #   @exchange_rates ||= Euresource::ExchangeRate.get(:all, params: {build_tag: 65}, method: :index)
      # end
    end
  end
end
