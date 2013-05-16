# -*- coding: utf-8 -*-
FactoryGirl.define do

  factory :md2d do
    revision '1.2.1'

    factory :md2d_pendulum0 do
      json_rep do
        {
          "_type" => "md2d",
          "imagePath" => "",
          "width" => 5,
          "height" => 3,
          "unitsScheme" => "md2d",
          "lennardJonesForces" => true,
          "coulombForces" => false,
          "temperatureControl" => false,
          "gravitationalField" => 9.8e-8,
          "timeStep" => 5,
          "dielectricConstant" => 1,
          "realisticDielectricEffect" => true,
          "solventForceFactor" => 1.25,
          "solventForceType" => 0,
          "additionalSolventForceMult" => 4,
          "additionalSolventForceThreshold" => 10,
          "polarAAEpsilon" => -2,
          "viscosity" => 1,
          "timeStepsPerTick" => 50,
          "geneticEngineState" => "dna",
          "DNA" => "",
          "viewOptions" => {
            "viewPortWidth" => 5,
            "viewPortHeight" => 3,
            "viewPortZoom" => 1,
            "viewPortX" => 0,
            "viewPortY" => 0,
            "backgroundColor" => "#eeeeee",
            "showClock" => true,
            "markColor" => "#f8b500",
            "keShading" => false,
            "chargeShading" => false,
            "useThreeLetterCode" => true,
            "aminoAcidColorScheme" => "hydrophobicity",
            "showChargeSymbols" => true,
            "showVDWLines" => false,
            "VDWLinesCutoff" => "medium",
            "showVelocityVectors" => false,
            "showForceVectors" => false,
            "showAtomTrace" => false,
            "images" => [],
            "imageMapping" => {},
            "textBoxes" => [],
            "xlabel" => false,
            "ylabel" => false,
            "xunits" => false,
            "yunits" => false,
            "controlButtons" => "play",
            "gridLines" => false,
            "atomNumbers" => false,
            "enableAtomTooltips" => false,
            "enableKeyboardHandlers" => true,
            "atomTraceColor" => "#6913c5",
            "velocityVectors" => {
              "color" => "#000",
              "width" => 0.01,
              "length" => 2
            },
            "forceVectors" => {
              "color" => "#169C30",
              "width" => 0.01,
              "length" => 2
            }
          },
          "pairwiseLJProperties" => [],
          "elements" => {
            "mass" => [
                       3.96,
                       480,
                       480,
                       0.25,
                       600
                      ],
            "sigma" => [
                        0.07,
                        0.28,
                        0.28,
                        0.28,
                        0.3
                       ],
            "epsilon" => [
                          -0.1,
                          -0.0010000000474974513,
                          -0.0010000000474974513,
                          -0.0010000000474974513,
                          -5
                         ],
            "color" => [
                        -855310,
                        -9066941,
                        -9092186,
                        -2539040,
                        -855310
                       ]
          },
          "atoms" => {
            "x" => [
                    2.5,
                    3.2071067811865475
                   ],
            "y" => [
                    2.75,
                    2.042893219
                   ],
            "vx" => [
                     0,
                     0
                    ],
            "vy" => [
                     0,
                     0
                    ],
            "charge" => [
                         0,
                         0
                        ],
            "friction" => [
                           0,
                           0
                          ],
            "element" => [
                          0,
                          3
                         ],
            "pinned" => [
                         1,
                         0
                        ]
          },
          "radialBonds" => {
            "atom1" => [
                        0
                       ],
            "atom2" => [
                        1
                       ],
            "length" => [
                         1
                        ],
            "strength" => [
                           1
                          ],
            "type" => [
                       105
                      ]
          }
        }

      end
    end
  end
end
