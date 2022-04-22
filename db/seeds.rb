llama = User.create!(email: "llama@example.com", password: "asdf", password_confirmation: "asdf", nickname: "llama")
kevin = User.create!(email: "kevin@example.com", password: "asdf", password_confirmation: "asdf", nickname: "kevin")
kate = User.create!(email: "kate@example.com", password: "asdf", password_confirmation: "asdf", nickname: "kate")

50.times do
  post = Post.new(user: [llama, kevin, kate].sample,
                  contents: Faker::Lorem.paragraph(sentence_count: rand(5..10)),
                  layout: [:top, :bottom, :left, :right].sample)
  post.image.attach(io: File.open(Rails.root.join('public', 'llama.jpg')), filename: 'llama.jpg')
  post.save!
end

[llama, kevin, kate].each do |user|
  Post.all.sample(rand(5..15)).each do |post|
    Like.create!(user: user, post: post)
  end
end
