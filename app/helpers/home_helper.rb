module HomeHelper
  BANNER_IMAGES = %w(paint peppers).freeze
  BANNER_START = '2018-08-20'.to_date
  BANNER_INDEX = '2018-08-06'.to_date
  BANNER_ROTATION = 14

  def banner_image(today = Date.current)
    if today >= BANNER_START
      BANNER_IMAGES[banner_image_index(today)]
    else
      ''
    end
  end

  private

  def banner_image_index(today)
    ((today - BANNER_INDEX).to_i / BANNER_ROTATION) % BANNER_IMAGES.size
  end
end
