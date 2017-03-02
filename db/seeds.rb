# Seed the currently fixed set of cards templates.
Template.first_or_create [
  { name: "Standard Blue", image: "standard-blue.png", description: nil },
  { name: "Standard Green", image: "standard-green.png", description: nil },
  { name: "Standard Orange", image: "standard-orange.png", description: nil },
  { name: "Standard Red", image: "standard-red.png", description: nil },
  { name: "Standard Yellow", image: "standard-yellow.png", description: nil },
  { name: "Art 1", image: "art-1-card.png", description: nil },
  { name: "Art 1 (cover)", image: "art-1-cover.png", description: nil },
  { name: "Art 2", image: "art-2-card.png", description: nil },
  { name: "Art 2 (cover)", image: "art-2-cover.png", description: nil },
  { name: "Bussiness Card (Front)", image: "bussiness-card-front.png", description: nil },
  { name: "Bussiness Card (back)", image: "bussiness-card-back.png", description: nil },
  { name: "Framed Nicley 1", image: "framed-nicely-1.png", description: nil },
  { name: "Framed Nicley 2", image: "framed-nicely-2.png", description: nil },
  { name: "Cartoon 1", image: "cartoon-1.png", description: nil },
  { name: "Cartoon 2", image: "cartoon-2.png", description: nil },
  { name: "Cartoon 3", image: "cartoon-3.png", description: nil },
  { name: "Cute 1", image: "cute-1.png", description: nil },
  { name: "Cute 2", image: "cute-2.png", description: nil },
  { name: "Fine 1", image: "fine-1.png", description: nil },
  { name: "Fine 2", image: "fine-2.png", description: nil },
  { name: "Fine 3", image: "fine-3.png", description: nil },
  { name: "Fine 4", image: "fine-4.png", description: nil },
  { name: "Fine 5", image: "fine-5.png", description: nil },
  { name: "Fine 6", image: "fine-6.png", description: nil },
  { name: "Fine 7", image: "fine-7.png", description: nil },
  { name: "Fine 8", image: "fine-8.png", description: nil },
  { name: "Fine 9", image: "fine-9.png", description: nil },
  { name: "Fine 10", image: "fine-10.png", description: nil },
  { name: "Fine 11", image: "fine-11.png", description: nil },
  { name: "Fine 12", image: "fine-12.png", description: nil },
  { name: "Fine 13", image: "fine-13.png", description: nil },
  { name: "Fine 14", image: "fine-14.png", description: nil },
  { name: "Fine 15", image: "fine-15.png", description: nil }
]

# Seed the experimental users.
User.first_or_create [
  { nickname: "zohoor", first_name: "Zohoor", last_name: "love", email: "zohoor@example.com",
    password: "112233", password_confirmation: "112233" },
  { nickname: "abdullah", first_name: "Dhyaa", last_name: "abdullah", email: "dhyaa@example.com",
    password: "112233", password_confirmation: "112233" },
]

# Seed the experimental cards with content.
Card.first_or_create title: "Inspiring Quote", description: "To keep us positive and motivated.",
                     draft: false, template_id: 7, user_id: 1

TextualContent.first_or_create [
  { content: "Comparison is the death of joy.", card_id: 1, font_size: 25, font_family: "Georgia",
  color: "black", width: 350, height: 35, x_position: 8, y_position: 85 },
  { content: "Mark Twain", card_id: 1, font_size: 18, font_family: "Serif", color: "(135, 20, 20)",
    width: 105, height: 25, x_position: 230, y_position: 140 }
]
