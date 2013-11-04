Profile.all.each do |profile|
    Given /^"(.+)" is a #{profile.label}$/ do |login|
        User.create!({
                :login => login,
                :password => 'password',
                :email => "#{login}@blog.com",
                :profile_id => profile.id,
                :state => 'active'
            })
    end
end
