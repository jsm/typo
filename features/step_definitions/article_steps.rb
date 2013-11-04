Given /^"(.+)" is published by "(.+)" with the following text:$/ do |title, author, multiline|
  author = User.find_by_login(author)
  content = multiline.split(/\n/).collect do |phrase|
    phrase.strip
  end.join("\n")
  Article.create({
      :user => author,
      :author => author.login,
      :title => title,
      :body => content
    })
end

Given /^a guest comments on "(.+)" with "(.+)"$/ do |article_title, comment|
  article = Article.find_by_title(article_title)
  old_count = article.comments.count

  Comment.create!({
      :type => "Comment",
      :author => "commenter",
      :body => "asdfasdf",
      :email => "commenter@blog.com",
      :url => "http://commenter.com",
      :published  => true,
      :ip => "127.0.0.1",
      :article_id => article.id
    })

  article = Article.find_by_title(article_title)
  article.comments.count.should == old_count + 1
end

Then /^"(.*?)" should have a title of "(.*?)"$/ do |article_title, title|
  article = Article.find_by_title(article_title)
  article.title.should == title
end

Then /^"(.*?)" should have an author of "(.*?)"$/ do |article_title, author|
  article = Article.find_by_title(article_title)
  article.author.should == author
end

Then /^"(.*?)" should have (\d+) comments$/ do |article_title, num_comments|
  article = Article.find_by_title(article_title)
  article.comments.count.should == num_comments.to_i
end

Then /^"(.*?)" should have the following body:$/ do |article_title, multiline|
  article = Article.find_by_title(article_title)
  content = multiline.split(/\n/).collect do |phrase|
    phrase.strip
  end.join("\n")
  article.body.should == content
end
