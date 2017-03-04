FactoryGirl.define do
  # Sample User factory
  factory :user do
    first_name "John"
    last_name  "Doe"
    nickname "johnny"
    email "John@doe.com"
    password "112233"
    password_confirmation "112233"
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
end
