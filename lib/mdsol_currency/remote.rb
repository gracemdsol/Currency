module Mdsol
  class Remote
    class << self
      def countries
        @countries ||= Euresource::Country.get(:all, params: {per_page: 300}, method: :index)
      end

      def currencies
        @currencies ||= Euresource::Currency.get(:all, params: {per_page: 300}, method: :index)
      end

      def location_defaults
        @location_defaults ||= Euresource::LocationDefault.get(:all)
      end

      def latest_build_tag
        @latest_build_tag ||= Euresource::BuildTag.get(:all).first.tag
      end

      # =========================================== Exchange Rates ==============================================

      # Preload last four builds' exchange rates
      def exchange_rates(build_tag:)
        case build_tag
          when latest_build_tag
            @latest_exchange_rates ||= Euresource::ExchangeRate.get(:all, params: {build_tag: build_tag}, method: :index)
          when latest_build_tag - 1
            @second_last_exchange_rates ||= Euresource::ExchangeRate.get(:all, params: {build_tag: build_tag}, method: :index)
          when latest_build_tag - 2
            @third_last_exchange_rates ||= Euresource::ExchangeRate.get(:all, params: {build_tag: build_tag}, method: :index)
          when latest_build_tag - 3
            @fourth_last_exchange_rates ||= Euresource::ExchangeRate.get(:all, params: {build_tag: build_tag}, method: :index)
          else
            Euresource::ExchangeRate.get(:all, params: {build_tag: build_tag}, method: :index)
        end
      end

      # =========================================== GMP Viewable ==============================================

      def viewable_country_uuids
        @viewable_country_uuids ||= location_defaults.each_with_object([]) do |obj, arr|
          arr << obj.uri.split(':').last if obj.is_gmp_viewable
        end
      end

      def viewable_currency_uuids
        @viewable_currency_uuids ||= location_defaults.each_with_object([]) do |obj, arr|
          arr << obj.default_currency_uuid if obj.is_gmp_viewable
        end.uniq
      end
    end
  end
end
