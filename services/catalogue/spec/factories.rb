Factory.define :dataset  do |i|
  i.name "test item name"
  i.uuid "3068e840-2fe6-11e0-91fa-0800200c9a66"
  i.description "test description"
  i.methodology "test methodology"
  #i.datasets [Dataset.new]
  #i.association :dataset_groups
end

Factory.define :dataset_fully_loaded, :class => 'Dataset' do |i|
  i.association :dataset_groups
  i.features { |f| [f.association(:feature), f.association(:feature)] }
end

Factory.define :dataset_group do |d|
  d.association :dataset
end

Factory.define :dataset_groups, :class => 'DatasetGroup' do |g|
  g.name "test group"
  #g.association :datasets
  g.datasets { |f| [f.association(:dataset), f.association(:dataset)] }
end

Factory.define :feature do |f|
  f.sequence(:name) { |n| "test feature name #{n}}}" }
  f.sequence(:description) { |n| "test feature description #{n}}}" }
  #f.association :observation, :factory => :observation
  f.feature_attributes { |f| [f.association(:feature_attribute), f.association(:feature_attribute)] }
end

Factory.define :observation do |o|
  o.json "{{'sample_json': true}}"
end

Factory.define :feature_attribute do |f|
  f.name "test feature attribute name"
  f.unit "test feature attribute description"
end