
require 'rqrcode'

module BikesHelper
  def qrcode(bike)
    RQRCode::QRCode.new(found_bike_url(h: bike.hash_id), :size => 4, :level => :l)
  end
end
