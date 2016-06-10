require 'rails_helper'

# Capybara DSL (Domain specific language)

feature 'Gangs index', js: true do

	context 'with no gangs' do
		before (:each) do
			# root_path = gangs#index
			visit root_path
		end

		scenario 'header validation' do
			expect(find('#header').text.strip).to eq('Da Hood')
		end

		scenario 'correct message if not gangs' do
			expect(find('#no-gangs-header').text).to eq('No Gangs, The City Is Clean!')
		end

		scenario 'create a gang' do
			find('#new-gang-btn').click
			fill_in('gang[name]', with: 'West Side')
			# CODE WAY- find the form by id and call form.submit
			# USER Way-find the submit button and click it
			find('#submit-gang-btn').click
			expect(find('.card-title').text).to eq('West Side')
		end

		scenario 'fill out the gang form and back out' do
			visit new_gang_path
			fill_in('gang[name]', with: 'West Side')
			find('#cancel-gang').click
			expect(find('#header')).to_not be(nil)
			expect(first('.card-title')).to eq(nil)
		end
	end

	context 'with gangs' do
		before (:each) do
			@gang_name = 'Bloods'
			@gang = Gang.create(name: @gang_name)
			visit root_path
		end
		scenario 'gang card is correct' do
			expect(find('.card-title').text).to eq(@gang_name)
		end

		scenario 'gang show button' do
			first('.gang-show-btn').click
			expect(find('#gang-header').text).to eq(@gang_name)
		end
	end
end