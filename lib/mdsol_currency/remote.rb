class MdsolCurrency
  module Remote
    def remote_countries
      @remote_countries ||= Euresource::Country.get(:all, params: {per_page: 300}, method: :index)
    end

    def remote_currencies
      @remote_currencies ||= Euresource::Currency.get(:all, params: {per_page: 300}, method: :index)
    end

    def remote_location_defaults
      @remote_location_defaults ||= Euresource::LocationDefault.get(:all)
    end

    def remote_exchange_rates(build_tag:)
      Euresource::ExchangeRate.get(:all, params: {build_tag: build_tag}, method: :index)
    end

    def latest_build_tag
      @latest_build_tag ||= Euresource::BuildTag.get(:all).first.tag
    end

    def latest_exchange_rates
      @latest_exchange_rates ||= Euresource::ExchangeRate.get(:all, params: {build_tag: latest_build_tag}, method: :index)
    end

    def viewable_country_uuids
      @viewable_country_uuids ||= location_defaults.each_with_object([]) do |obj, arr|
        arr << obj.uuid if obj.is_gmp_viewable
      end
    end

    def viewable_currency_uuids
      @viewable_currency_uuids ||= location_defaults.each_with_object([]) do |obj, arr|
        arr << obj.default_currency_uuid if obj.is_gmp_viewable
      end.uniq
    end
  end
end
