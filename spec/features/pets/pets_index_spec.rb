require 'rails_helper'

RSpec.describe "As a user" do
  describe "when i visit pets index", type: :feature do
    before :each do
      @phils_shelter = Shelter.create(  name:     "Phil's Shelter",
                                        address:  "1234 Address St.",
                                        city:     "Denver",
                                        state:    "CO",
                                        zip:      "80202"
      )
      @charles = Pet.create(  image:        '/pet_charles.jpg',
                              name:         "Charles",
                              age:          5,
                              sex:          "Male",
                              shelter_id:   @phils_shelter.id
      )
      visit "/pets"
    end

    it "i can see all adoptable pets" do

      expect(page).to have_css("img[src*='#{@charles.image}']")
      expect(page).to have_content(@charles.name)
      expect(page).to have_content(@charles.age)
      expect(page).to have_content(@charles.sex)
    end

    it "i can click and edit each pet" do
      click_on 'Edit Charles'
      expect(current_path).to eq("/pets/#{@charles.id}/edit")
    end

    it "i can click and delete each pet" do
      click_on 'Delete Charles'
      expect(current_path).to eq("/pets")

      expect(page).to_not have_content(@charles.name)
    end

    it "i click pets name and see pets show page" do
      click_on "#{@charles.name}"
      expect(current_path).to eq("/pets/#{@charles.id}")
      click_on "#{@charles.name}"
      expect(current_path).to eq("/pets/#{@charles.id}")
    end
  end
end
