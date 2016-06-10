require 'rails_helper'


feature 'thugs index', js: true do
		before (:each) do
			@gang_name = 'Bloods'
			@gang = Gang.create(name: @gang_name)
			visit root_path
			find('.gang-show-btn').click
			find('.gang-member-btn').click
		end

		context 'with no thugs' do

			scenario 'header vaildation' do
				expect(find('#thug-header').text.strip).to eq("Thugs In the Gang: #{@gang_name}")
			end
		end
		context 'with thugs' do
			before (:each) do 
				@name = 'Tyler'
				find('.create-thug-btn').click
				fill_in('thug[name]', with: @name)
				find('#submit-thug').click
				find('#gang-thug').click
			end
			scenario 'create a thug' do
				expect(find('.gang-thug').text).to eq("Thug: #{@name}")
			end

			scenario 'edit a thug' do
				find('.edit-thug-btn').click
				@name = 'Ruffice'
				fill_in('thug[name]', with: @name)
				find('#submit-thug').click
				expect(find('.gang-thug').text).to eq("Thug: #{@name}")
			end

			scenario 'delete a thug' do
				find('.delete-thug-btn').click
				expect(first('.gang-thug')).to eq(nil)
			end

			scenario 'go back' do
				find('thug-back').click
				expect(find('#thug-header').text.strip).to eq("Thugs In the Gang: #{@gang_name}")
			end

		end

end