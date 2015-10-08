# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'Middleware' do

  context 'when request is for resize' do

    context 'when resized image does not exist' do

      context 'when all dimensions are allowed' do

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

      context 'when allowed dimensions set' do

        before(:each) do
          LightResizer.configuration.allowed_dimensions = [[200, 200], [300, 200], [200, 300]]
        end

        context 'when dimension is allowed' do

          before(:each) do
            visit '/uploads/test/light_resizer/200x200/dragon.jpg'
          end

          it 'has status 200' do
            expect(page.status_code).to eq(200)
          end

        end

        context 'when dimension is not allowed' do

          it 'has light resizer error' do
            expect { visit('/uploads/test/light_resizer/300x300/dragon.jpg') }.to raise_error LightResizer::DimensionNotFound
          end

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