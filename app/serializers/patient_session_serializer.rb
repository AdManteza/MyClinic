class PatientSessionSerializer < ActiveModel::Serializer
  attributes :id, :date, :start_time, :end_time
end