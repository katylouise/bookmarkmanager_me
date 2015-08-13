FactoryGirl.define do
  factory :ma, class: Link do
    url 'http://www.makersacademy.com'
    title 'Makers Academy'
  end

  factory :gg, class: Link do
    url 'http://www.google.com'
    title 'Google'
  end

  factory :zm, class: Link do
    url 'http://www.zombo.com'
    title 'This is Zombocom'
  end

  factory :bb, class: Link do
    url 'http://www.bubble-bobble.com'
    title 'Bubble Bobble'
  end
end

