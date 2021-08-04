
module FactoryHelpers
  def self.upload_file(src, content_type, binary = false)
    path = Rails.root.join(src)
    original_filename = ::File.basename(path)

    content = File.open(path).read
    tempfile = Tempfile.open(original_filename)
    tempfile.write content
    tempfile.rewind

    uploaded_file = Rack::Test::UploadedFile.new(tempfile, content_type, binary, original_filename: original_filename)

    ObjectSpace.define_finalizer(uploaded_file, uploaded_file.class.finalize(tempfile))

    uploaded_file
  end
end

FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price(range: 100.0..400.0) }

    image { Rack::Test::UploadedFile.new(FactoryHelpers.upload_file("spec/support/images/product_image.png", "image/png", true)) }
    
    after :build do |product|
      product.productable = create(:game)
    end
  end
end
