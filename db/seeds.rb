if House.all == []
g = House.create(name: "Gryffindor")
h = House.create(name: "Hufflepuff")
r = House.create(name: "Ravenclaw")
s = House.create(name: "Slytherin")
Student.create(username: "Dumbledore", password: "a", house_id: "1", admin: true)
Student.create(username: "Pomona", first_name: "Pomona", last_name: "Sprout", password: "a", house_id: "2", admin: true)
Student.create(username: "Rowena", first_name: "Rowena", last_name: "Ravenclaw", password: "a", house_id: "3", admin: true)
Student.create(username: "Salazar", first_name: "Salazar", last_name: "Slytherin", password: "a", house_id: "4", admin: true)

end

i = 0
while i < 100
    g = House.find(1)
    h = House.find(2)
    r = House.find(3)
    s = House.find(4)
    arr = [g, h, r, s]
    # House.all.each do |house|
    #     arr << house
    # end
    
    a = arr[rand(4)]
    cup = a.cup_winners.create(:name => a.name)

    cup.year = 1920 + i
    
    cup.save
    i += 1
end