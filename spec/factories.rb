Factory.sequence :name do |n|
  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua".split(' ').shuffle.sample(8).join(' ')
end

Factory.sequence :lastname do |n|
  "person-lastname-#{n}"
end

Factory.sequence :title do |n|
  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua".split(' ').shuffle.sample(8).join(' ')
end

Factory.sequence :description do |n|
  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua".split(' ').shuffle.sample(8).join(' ')
end

Factory.sequence :address do |n|
  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua".split(' ').shuffle.sample(8).join(' ')
end

Factory.sequence :email do |n|
  "person#{n}@example.com" 
end

Factory.define :company do |f|
  f.latitude "45"
  f.longitude "10"
  f.altitude "2"
  f.name { Factory.next(:name) }
  f.description "company description"
  f.piva "0123456789"
  f.url_site "http://www.google.it"
  f.email_address { Factory.next(:email) }
  f.phone "1234567"
  f.fax "1234567"
  f.timetable ""
  f.facebook "http://www.google.it"
  f.twitter "http://www.google.it"
  f.youtube "http://www.google.it"
  f.tokens 0
  f.is_exclusive false 
  f.address { Factory.next(:address) }
  f.is_enabled true
  f.rank 0
  f.privacy 1
  f.association :city
end

Factory.define :city do |f|
  f.name "city"
end

Factory.define :category do |f|
  f.title { Factory.next(:title) }
  f.description { Factory.next(:description) }
  f.mtitle { Factory.next(:description) }
  f.mdescription { Factory.next(:description) }
  f.mkey { Factory.next(:description) }
end

Factory.define :department do |f|
  f.name { Factory.next(:name) }
end

Factory.define :estimate do |f|
  f.name { Factory.next(:name) }
  f.lastname { Factory.next(:lastname) }
  f.address { Factory.next(:address) }
  f.email { Factory.next(:email) }
  f.phone "12345"
  f.note { Factory.next(:description) }
  f.privacy 1
  f.association :city
end