module SpreeMultiVendor::Spree::Stock::PackageDecorator
  def shipping_methods
    vendor = Spree::StockLocation.method_defined?(:vendor) ? stock_location.vendor : nil

    # return only shipping methods for this Vendor
    if vendor && Spree::ShippingMethod.method_defined?(:vendor)
      vendor.shipping_methods.to_a
    else
      shipping_categories.map(&:shipping_methods).reduce(:&).select{|x| x.vendor_id.nil? }.to_a
    end
  end
end

Spree::Stock::Package.prepend SpreeMultiVendor::Spree::Stock::PackageDecorator
