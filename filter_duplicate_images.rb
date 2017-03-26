#! ~/.rvm/rubies/ruby-2.2.4/bin/ruby


def filter_duplicate_images
  ManageIQ::Providers::ContainerManager.all.each do |ems|
    filtered_images = []
    ems.container_images.all.each do |image|
      filtered_images << image
    end
    filtered_images.uniq! { |im| im.digest || im.image_ref }
    ems.container_images.all.each do |image|
      image.disconnect_inv if !filtered_images.include?(image)
    end
  end
end

filter_duplicate_images
