# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).


puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :username => 'IvoReis', :email => 'reis.ivo@gmail.com', :password => 'qwerty', :password_confirmation => 'qwerty', :confirmed_at => DateTime.now
puts 'New user created: ' << user.username

user2 = User.create! :username => 'AndreReis', :email => 'andre_reis@ivoreis.com', :password => 'qwerty', :password_confirmation => 'qwerty', :confirmed_at => DateTime.now
puts 'New user created: ' << user2.username

person = Person.build_from user, :staff, :male
puts "Person name #{person.profile.name}"

person2 = Person.build_from user2, :moderator, :male
puts "Person name #{person2.profile.name}"

genders = [:male, :male, :female, :male, :male, :female, :female, :female, :female, :female, :male, :male, :female, :male, :male, :male, :male]

['Andre Santos', 'Pedro Cunha', 'Carla Afonso', 'Carlos Silva', 'Vasco Queiros', 'Helena Duarte', 'Marta Silva', 'Filipa Lencastre', 'Joana Fonseca', ' Vera Gomes', 'Joao Pinto', 'Joao Silva', 'Daniela Basto', 'Jose Mota', 'Candido Almeida', 'Vitor Batista', 'Jorge Cunha'].each_with_index do |name, index|
  eval <<-EOM
      user_#{name.downcase.split(' ').join('_')} = User.create! :username => '#{name.gsub(" ", "")}', :email => '#{name.downcase.split(' ').join('_')}@ivoreis.com', :password => 'qwerty', :password_confirmation => 'qwerty', :confirmed_at => DateTime.now
      puts 'New user created: ' << user_#{name.downcase.split(' ').join('_')}.username
      Person.build_from user_#{name.downcase.split(' ').join('_')}, :member, #{genders}[#{index}]
  EOM
end

PersonProfile.all.each do |entry|
  entry.country = :Portugal
  entry.save!
end




room = Forum::Room.create!(title: "Conversas Gerais", description: "Fale sobre tudo o que quiser!", public: true, institutional: true)
puts 'Created room: ' << room.title

room2 = Forum::Room.create!(title: "Conversas de Parkinson", description: "Tudo o que seja relacionado com Parkinson", public: true, institutional: false)
puts 'Created room: ' << room2.title

room3 = Forum::Room.create!(title: 'Dicas', description: "Como se pode melhorar esta comunidade?", public: true, institutional: false)
puts 'Created room: ' << room3.title

room4 = Forum::Room.create!(title: "Actividades", description: "Coloque aqui dicas para actividades futuras", public: true, institutional: false)
puts 'Created room: ' << room4.title

room5 = Forum::Room.create!(title: "Grupo privado", description: "Conversas sobre temas mais delicados e em privado", public: false, institutional: false)
puts 'Created room: ' << room5.title


# Add the person as a group member
room.add_member! person
room5.add_member! person

# Fill the rooms with some topics
topic1 = room.topics.create(title: "Apresentações", content: "Apresente-se aos outros elementos da comunidade! Diga um uma!", owner: person )
topic2 = room.topics.create(title: "O que gosto de fazer", content: "O que gosta de fazer para passar o tempo?", owner: person )

topic3 = room2.topics.create(title: "Tratamentos Parkinson", content: "Partilhe informações uteis sobre tratamentos", owner: person )
topic4 = room2.topics.create(title: "Dicas sobre Parkinson", content: "Algumas dicas para passar melhor o dia...", owner: person )
topic5 = room2.topics.create(title: "Sabia que?", content: "curiosidades sobre a doença...", owner: person )

topic6 = room3.topics.create(title: "Sugestões Gerais", content: "Deixe aqui as suas sugestões", owner: person )

topic9 = room4.topics.create(title: "Actividades ao ar livre", content: "Que actividades se podem fazer ao ar livre?", owner: person )
topic10 = room4.topics.create(title: "Actividades dentro de casa", content: "O que se pode fazer dentro de casa?", owner: person )



