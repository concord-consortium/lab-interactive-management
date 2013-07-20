FactoryGirl.define do

  factory :group do
    revision '1.2.1'
    factory :inquiry_pendulum do
      path "inquiry-space/pendulum"
      name "Inquiry Space: Pendulums"
      category "Curriculum"
    end
  end
end
