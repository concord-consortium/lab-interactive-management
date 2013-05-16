# -*- coding: utf-8 -*-
FactoryGirl.define do

  factory :interactive do
    revision '1.2.1'

    factory :pendulum do
      json_rep do
        {
          "title" =>  "Pendulum",
          "path" =>  "interactives/inquiry-space/pendulum/1-pendulum.json",
          "groupKey" =>  "inquiry-space/pendulum",
          "subtitle" =>  "Explore some factors that affect the period of a pendulum.",
          "about" =>  [
                       "Press the play button. Watch the graph to see how the angle of the pendulum changes as it",
                       "swings back and forth. Use the graph to determine the period of the pendulum. Adjust the",
                       "scale by dragging the numbers on the axes. Change each variable – gravity, rod length,",
                       "starting angle and mass – and observe how each one affects the period. Can you explain why?",
                       "Try the damping slider. Does damping change the period?"
                      ],
          "publicationStatus" =>  "public"
        }
      end
      after(:create) do |interactive, evaluator|
         interactive.md2ds = FactoryGirl.create_list(:md2d_pendulum0, 1)# , :interactive => interactive)
       end
      after(:create) do |interactive, evaluator|
        interactive.group = create(:inquiry_pendulum)

      end
    end
  end
end
