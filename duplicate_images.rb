#! ~/.rvm/rubies/ruby-2.2.4/bin/ruby

def generate_duplicate_images(n=1)
  ManageIQ::Providers::ContainerManager.all.each do |ems|
    images = []
    ems.container_images.all.each do |image|
      images << image
    end
    n.times do
      images.each do |image|
        duplicate_image(ems, image)
      end
    end
  end
end

def duplicate_image(ems, image)
  ems.container_images.create(
    :name                        => image.name,
    :image_ref                   => image.image_ref,
    :digest                      => image.digest,
    :container_image_registry_id => image.container_image_registry_id
  ).save
end


generate_duplicate_images
