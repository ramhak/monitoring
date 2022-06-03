require 'rails_helper'
RSpec.describe 'routes for all paths', type: :routing do
  it 'other than apis should goes to the pages#index' do
    expect(get('/')).to route_to('pages#index')
  end
  it 'when path is wrong goes to the pages#index' do
    expect(get: '/wrongpath')
      .to route_to(controller: 'pages', action: 'index', path: 'wrongpath')
  end
end
