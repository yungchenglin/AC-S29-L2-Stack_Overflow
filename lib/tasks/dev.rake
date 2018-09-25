namespace :dev do
  task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate"] 
  task :rebuild => [ "dev:build","db:seed", :fake_user, :fake_question, :fake_answer, :fake_question_upvote, :fake_answer_upvote, :fake_favorite, :fake_tag, :fake_question_tag]
  
  task fake_user: :environment do
    TITLE_LIST = ["產品經理", "軟體工程師", "藝術總監", "會計師", "平面設計師", "硬體工程師", "品質驗證師", "專案經理", "人資"]
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open(Rails.root.join("public/avatar/user#{i+1}.jpg"))
      user = User.create!(
        name: name,
        email: "#{name}@stackoverflow.com",
        twitter: "#{name}@twitter.test",
        github: "#{name}@github.test",
        website: "#{name}@website.test",
        password: "12345678",
        title: TITLE_LIST.sample,
        company: FFaker::Lorem::word+".Inc",
        introduction: FFaker::Lorem::sentence(20),
        role: "normal",
        avatar: file
      )
      puts user.name
    end
  end

  task fake_question: :environment do
    Question.destroy_all
    30.times do |i|
      user = User.all.sample
      question = Question.create!(
        description: FFaker::Lorem::sentence(8),
        user: user,
        title: FFaker::Lorem::sentence(1),
        created_at: FFaker::Time::datetime
      )
    end
    puts "Total #{Question.count} questions created !"
  end

  task fake_answer: :environment do
    Answer.destroy_all
      30.times do |i|
        user = User.all.sample
        question = Question.all.sample
        answer = Answer.create!(
          user: user,
          question: question,
          content: FFaker::Lorem::sentence(3),
          created_at: FFaker::Time::datetime
        )
      end
    puts "Total #{Answer.count} answers created !"
  end

  task fake_question_upvote: :environment do
    QuestionUpvote.destroy_all
      50.times do |i|
        user = User.all.sample
        question = Question.all.sample
        question_upvote = QuestionUpvote.create!(
          question: question,
          user: user,
          created_at: FFaker::Time::datetime
        )
      end
    puts "Total #{QuestionUpvote.count} question_votes created !"
  end

    task fake_answer_upvote: :environment do
    AnswerUpvote.destroy_all
      50.times do |i|
        user = User.all.sample
        answer = Answer.all.sample
        answer_upvote = AnswerUpvote.create!(
          answer: answer,
          user: user,
          created_at: FFaker::Time::datetime
        )
      end
    puts "Total #{AnswerUpvote.count} answer_votes created !"
  end

  task fake_favorite: :environment do
    Favorite.destroy_all
      50.times do |i|
        user = User.all.sample
        question = Question.all.sample
        favorite = Favorite.create!(
          question: question,
          user: user,
          created_at: FFaker::Time::datetime
        )
      end
    puts "Total #{Favorite.count} favorites created !"
  end

  task fake_tag: :environment do
    Tag.destroy_all
    TAG_LIST = ["藝術", "科技", "趣味", "旅遊", "美食", "穿著"]
    TAG_LIST.each do |tag|
      Tag.create!(name: tag)
    end

    puts "Default Tags Created!"
  end

  task fake_question_tag: :environment do
    QuestionTag.destroy_all
      50.times do |i|
        tag = Tag.all.sample
        question = Question.all.sample
        question_tag = QuestionTag.create!(
          question: question,
          tag: tag,
          created_at: FFaker::Time::datetime
        )
      end
    puts "Total #{QuestionTag.count} question_tags created !"
  end

  task fake_all: :environment do
    Rake::Task["db:migrate"].execute
    Rake::Task["db:seed"].execute
    Rake::Task["dev:fake_user"].execute
    Rake::Task["dev:fake_question"].execute
    Rake::Task["dev:fake_answer"].execute
    Rake::Task["dev:fake_question_upvote"].execute
    Rake::Task["dev:fake_answer_upvote"].execute
    Rake::Task["dev:fake_favorite"].execute
    Rake::Task["dev:fake_tag"].execute
    Rake::Task["dev:fake_question_tag"].execute

  end

end