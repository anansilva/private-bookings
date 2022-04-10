def single_bed
  { bed_size: 'single' }
end

def double_bed
  { bed_size: 'double' }
end

puts 'cleaning db...'
Listing.destroy_all

puts 'creating casa das cobras...'

Listing.create(
  title: 'Casa das cobras',
  max_guests: 12,
  nightly_price: 25.00,
  guest_price: 7.5,
  status: 'draft'
).then do |listing|
  listing.rooms.create!([
    { room_type: 'double', beds_attributes: [single_bed, single_bed] },
    { room_type: 'double', beds_attributes: [single_bed, single_bed] },
    { room_type: 'double', beds_attributes: [double_bed] },
    { room_type: 'double', beds_attributes: [double_bed] }
  ])
end

puts 'creating casa do tanque...'

Listing.create(
  title: 'Casa do tanque',
  max_guests: 6,
  nightly_price: 20.00,
  guest_price: 7.5,
  status: 'draft'
).then do |listing|
  listing.rooms.create!([
    { room_type: 'double', beds_attributes: [single_bed, single_bed] },
    { room_type: 'double', beds_attributes: [single_bed, single_bed] },
    { room_type: 'double', beds_attributes: [double_bed] },
  ])
end

puts 'creating casa grande...'

Listing.create(
  title: 'Casa grande',
  max_guests: 12,
  nightly_price: 25.00,
  guest_price: 7.5,
  status: 'draft'
).then do |listing|
  listing.rooms.create!([
    { room_type: 'double', beds_attributes: [double_bed] },
    { room_type: 'double', beds_attributes: [double_bed] },
    { room_type: 'double', beds_attributes: [single_bed, single_bed] },
    { room_type: 'double', beds_attributes: [single_bed, single_bed] },
    { room_type: 'double', beds_attributes: [single_bed, single_bed] },
    { room_type: 'double', beds_attributes: [single_bed, single_bed] },
  ])
end
