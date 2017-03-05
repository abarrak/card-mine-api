FactoryGirl.define do
  # Sample User factory
  fake_password = Faker::Internet.password 6, 128

  factory :user do
    first_name Faker::Name.first_name
    last_name  Faker::Name.last_name
    nickname Faker::Cat.name
    email Faker::Internet.email
    password fake_password
    password_confirmation fake_password
  end

  # Sample Template factory
  factory :template do
    name "Fine Card"
    image "fine-1.png"
    description nil
  end

  # Sample Card factory
  factory :card do
    title "Inspiring Quote"
    description "To keep us positive and motivated."
    draft false
    user
    template
  end

  # Sample Textual Content factory
  factory :textual_content do
    content "To be or not to be, this is the question"
    card
    font_size 14
    font_family "Arial"
    color "black"
    width 250
    height 40
    x_position 50
    y_position 120
  end

  # List of Templates factories
  factory :templates_list, class: Template do
    sequence(:name)   { |n| "Sample Card #{n}" }
    sequence(:image)  { |n| "sample-card-#{n}.png" }
  end

  # Other factories for later manipulation
  factory :new_user, class: User do
    nickname "john"
    email "john@example.com"
    password "111222"
    password_confirmation "111222"
  end

  factory :new_card, class: Card do
    title "~ My New Card ~"
    template
    user nil
  end
end
