
require 'rqrcode'

module BikesHelper
  def qrcode(bike)
    RQRCode::QRCode.new(url_for(found_bike_path, h: bike.hash_id))
  end
end
