# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'Middleware' do

  context 'when gets request' do

    context 'when request is for resize' do

      context 'when resized image does not exist' do

        context 'when without crop' do

          before(:each) do
            visit '/uploads/test/light_resizer/200x200/dragon.jpg'
          end

          it 'has status 200' do
            expect(page.status_code).to eq(200)
          end

        end

        context 'when with crop' do

          before(:each) do
            visit '/uploads/test/light_resizer/crop/200x200/dragon.jpg'
          end

          it 'has status 200' do
            expect(page.status_code).to eq(200)
          end

        end

      end

    end

    context 'when request is not for resize' do

      before(:each) do
        visit '/uploads/test/dragon.jpg'
      end

      it 'has status 200' do
        expect(page.status_code).to eq(200)
      end

    end

  end

end