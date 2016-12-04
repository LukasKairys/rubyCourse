RSpec.describe 'user/show.html.erb', type: :view do
  fixtures :all

  let(:user_one) do
    users(:user_one)
  end

  it 'displays all the tenders' do
    assign(:users,
           [user_one])

    render

    expect(rendered).to match user_one.email
  end
end
