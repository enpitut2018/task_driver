class Types::MomentInputType < Types::BaseInputObject

  argument :year, Integer, required: true
  argument :month, Integer, required: true
  argument :day, Integer, required: true
  argument :hour, Integer, required: true
  argument :minute, Integer, required: true
  argument :second, Integer, required: true
end