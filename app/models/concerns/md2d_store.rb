# Generated by rails generate md2d_store
# Depends on the definition of md2d in the lab project

# This must be included in the Md2d AR model
module Md2dStore
  extend ActiveSupport::Concern

  module ClassMethods
    # find the model where the json_rep['url'] == url
    def find_by_url(url)
      find do |g|
        g if g.json_rep['url'] == path
      end
    end
  end

  module InstanceMethods
  end

  included do
    # GENERATED
      store :json_rep, :accessors => [:viewOptions, :atom, :element, :pairwiseLJProperties, :obstacle, :radialBond, :angularBond, :restraint, :textBox, :imagePath, :minX, :maxX, :minY, :maxY, :width, :height, :unitsScheme, :lennardJonesForces, :coulombForces, :temperatureControl, :targetTemperature, :modelSampleRate, :gravitationalField, :timeStep, :dielectricConstant, :realisticDielectricEffect, :solventForceFactor, :solventForceType, :additionalSolventForceMult, :additionalSolventForceThreshold, :polarAAEpsilon, :viscosity, :timeStepsPerTick, :geneticEngineState, :DNA, :DNAComplement, :mRNA, :useQuantumDynamics, :elementEnergyLevels, :radiationlessEmissionProb, :url]
    # GENERATED
  end
end