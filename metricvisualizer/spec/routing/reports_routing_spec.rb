require 'rails_helper'

RSpec.describe '/api/v1/reports/ route', type: :routing do
  it 'without namespaces should goes to he pages#index ' do
    expect(get: '/reports')
      .to route_to(
        controller: 'pages',
        action: 'index',
        path: 'reports'
      )
  end
  it 'without name parameter should goes to the pages#index' do
    expect(get: '/api/v1/reports')
      .to route_to(
        controller: 'pages',
        action: 'index',
        path: 'api/v1/reports'
      )
  end
  it 'should goes to the report#index' do
    expect(get: '/api/v1/reports/test')
      .to route_to(
        controller: 'api/v1/reports',
        action: 'index',
        name: 'test'
      )
  end
  it 'should pass the parameters to the index action' do
    expect(get: '/api/v1/reports/test?start=2022-01-01&end=2022-01-03')
      .to route_to(
        controller: 'api/v1/reports',
        action: 'index',
        name: 'test',
        start: '2022-01-01',
        end: '2022-01-03'
      )
  end
  it 'should not response to the verbs other tha GET' do
    expect(delete: '/api/v1/reports/test').not_to be_routable
    expect(post: '/api/v1/reports/test').not_to be_routable
    expect(put: '/api/v1/reports/test').not_to be_routable
  end
end
