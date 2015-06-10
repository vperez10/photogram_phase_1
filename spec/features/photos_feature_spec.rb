require 'rails_helper'

RSpec.describe 'CRUD Photos', type: :feature do
  fixtures :photos

  let(:photo) { photos(:one) }

  describe "GET /photos" do
    it "displays photos", points: 1 do
      visit "/photos"

      expect(page).to have_content(photo.source)
      expect(page).to have_content(photo.caption)
    end
  end

  describe "GET /photos/:id" do
    it "displays photo", points: 3 do
      visit "/photos/#{photo.id}"

      expect(page).to have_content(photo.source)
      expect(page).to have_content(photo.caption)
    end
  end

  describe "GET /photos/new_form" do
    it "displays new photo form", points: 4 do
      visit "/photos/new_form"

      expect(page).to have_selector('input#source')
      expect(page).to have_selector('input#caption')
    end
  end

  describe "GET /create_photo" do
    it "creates new photo", points: 5 do
      visit "/photos/new_form"
      fill_in 'source', with: 'https://www.google.com/images/srpr/logo11w.png'
      fill_in 'caption', with: 'Google logo'

      form = page.find("form")
      class << form
        def submit!
          Capybara::RackTest::Form.new(driver, native).submit({})
        end
      end
      form.submit!

      expect(page).to have_content('https://www.google.com/images/srpr/logo11w.png')
      expect(page).to have_content('Google logo')
    end
  end

  describe "GET /photos/:id/edit_form" do
    it "displays edit photo form", points: 4 do
      visit "/photos"
      find(:xpath, "//a[@href='/photos/#{photo.id}/edit']").click

      expect(page).to have_selector("input#source[value='#{photo.source}']")
      expect(page).to have_selector("input#caption[value='#{photo.caption}']")
    end
  end

  describe "GET /update_photo/:id" do
    it "updates photo", points: 5 do
      visit "/photos/"
      find(:xpath, "//a[@href='/photos/#{photo.id}/edit_form']").click
      fill_in 'source', with: 'https://www.google.com/images/srpr/logo11w.png'
      fill_in 'caption', with: 'Google logo'

      form = page.find("form")
      class << form
        def submit!
          Capybara::RackTest::Form.new(driver, native).submit({})
        end
      end
      form.submit!

      expect(page).not_to have_content(photo.source)
      expect(page).not_to have_content(photo.caption)
      expect(page).to have_content('https://www.google.com/images/srpr/logo11w.png')
      expect(page).to have_content('Google logo')
    end
  end

  describe "GET /delete_photo/:id/" do
    it "deletes photo", points: 3 do
      visit "/photos/"
      find(:xpath, "//a[@href='/delete_photo/#{photo.id}']").click

      expect(page).not_to have_content(photo.source)
      expect(page).not_to have_content(photo.caption)
    end
  end
end
