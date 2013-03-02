
Factory.define :user do |u|
	u.name	"Bence Magyar"
	u.email	"foo@bar.com"
	u.password "foobar"
	u.password_confirmation "foobar"

end

Factory.sequence :email do |n|
  "person-#{n}@example.org"
end


Factory.define :book do |b|
	b.title	"The Adventures of Tom Sawyer"
	b.author_last	"Twain"
	b.author_first "Mark"
	b.description "An American Classic.  One of the most important books every written"
	b.year_published "1876"
	b.genre "American Literature"
	b.isbn  "9780195810400"

end


