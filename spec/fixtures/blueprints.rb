Sham.name  { Faker::Name.name }
Sham.value { Faker::Lorem.sentence }

DynAttr.blueprint do
  name
  value
  conf_unit { ConfUnit.make }
end

ConfUnit.blueprint do
  name
  active { true }
  active_last_checked { 1.hour.ago }
  parent_id nil
  dyn_attrs { [] }
end