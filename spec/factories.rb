
Factory.define :user do |u|
	u.name	"Bence Magyar"
	u.email	"foo@bar.com"
	u.password "foobar"
	u.password_confirmation "foobar"

end

Factory.sequence :email do |n|
  "person-#{n}@example.org"
end
