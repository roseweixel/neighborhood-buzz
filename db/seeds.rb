# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

manhattan_neighborhoods = Neighborhood.create([
{borough: "Manhattan", name: "Battery Park City"},
{borough: "Manhattan", name: "Carnegie Hill"},
{borough: "Manhattan", name: "Chelsea"},
{borough: "Manhattan", name: "East Harlem"},
{borough: "Manhattan", name: "East Village"},
{borough: "Manhattan", name: "Financial District"},
{borough: "Manhattan", name: "Flatiron"},
{borough: "Manhattan", name: "Gramercy"},
{borough: "Manhattan", name: "Hamilton Heights"},
{borough: "Manhattan", name: "Harlem"},
{borough: "Manhattan", name: "Hudson Heights"},
{borough: "Manhattan", name: "Inwood"},
{borough: "Manhattan", name: "Kips Bay"},
{borough: "Manhattan", name: "Lower East Side"},
{borough: "Manhattan", name: "Manhattan Valley"},
{borough: "Manhattan", name: "Midtown East"},
{borough: "Manhattan", name: "Midtown West"},
{borough: "Manhattan", name: "Morningside Heights"},
{borough: "Manhattan", name: "Mt. Morris Park"},
{borough: "Manhattan", name: "Murray Hill"},
{borough: "Manhattan", name: "NoHo"},
{borough: "Manhattan", name: "Roosevelt Island"},
{borough: "Manhattan", name: "Seaport"},
{borough: "Manhattan", name: "Soho"},
{borough: "Manhattan", name: "Sugar Hill"},
{borough: "Manhattan", name: "Tribeca"},
{borough: "Manhattan", name: "Union Square"},
{borough: "Manhattan", name: "Upper East Side"},
{borough: "Manhattan", name: "Upper West Side"},
{borough: "Manhattan", name: "Village"},
{borough: "Manhattan", name: "Washington Heights"},
{borough: "Manhattan", name: "West Village"}])

queens_neighborhoods = Neighborhood.create([
{borough: "Queens", name: "Arverne"},
{borough: "Queens", name: "Astoria"},
{borough: "Queens", name: "Bayside"},
{borough: "Queens", name: "Beechhurst"},
{borough: "Queens", name: "Bellerose"},
{borough: "Queens", name: "Breezy Point"},
{borough: "Queens", name: "Briarwood"},
{borough: "Queens", name: "Broad Channel"},
{borough: "Queens", name: "Cambria Heights"},
{borough: "Queens", name: "College Point"},
{borough: "Queens", name: "Corona"},
{borough: "Queens", name: "Douglaston"},
{borough: "Queens", name: "East Elmhurst"},
{borough: "Queens", name: "Elmhurst"},
{borough: "Queens", name: "Far Rockaway"},
{borough: "Queens", name: "Floral Park"},
{borough: "Queens", name: "Flushing"},
{borough: "Queens", name: "Forest Hills"},
{borough: "Queens", name: "Fresh Meadows"},
{borough: "Queens", name: "Glen Oaks"},
{borough: "Queens", name: "Glendale"},
{borough: "Queens", name: "Hollis"},
{borough: "Queens", name: "Howard Beach"},
{borough: "Queens", name: "Jackson Heights"},
{borough: "Queens", name: "Jamaica"},
{borough: "Queens", name: "JFK Airport"},
{borough: "Queens", name: "Kew Gardens"},
{borough: "Queens", name: "Kew Gardens Hills"},
{borough: "Queens", name: "Little Neck"},
{borough: "Queens", name: "Long Island City"},
{borough: "Queens", name: "Maspeth"},
{borough: "Queens", name: "Middle Village"},
{borough: "Queens", name: "Ozone Park"},
{borough: "Queens", name: "Queens Village"},
{borough: "Queens", name: "Rego Park"},
{borough: "Queens", name: "Richmond Hill"},
{borough: "Queens", name: "Ridgewood"},
{borough: "Queens", name: "Rockaway Park"},
{borough: "Queens", name: "Rosedale"},
{borough: "Queens", name: "South Jamaica"},
{borough: "Queens", name: "South Ozone Park"},
{borough: "Queens", name: "Springfield Gardens"},
{borough: "Queens", name: "St. Albans"},
{borough: "Queens", name: "Sunnyside"},
{borough: "Queens", name: "Utopia"},
{borough: "Queens", name: "Whitestone"},
{borough: "Queens", name: "Woodhaven"},
{borough: "Queens", name: "Woodside"}])

brooklyn_neighborhoods = Neighborhood.create([
{borough: "Brooklyn", name: "Bath Beach"},
{borough: "Brooklyn", name: "Bay Ridge"},
{borough: "Brooklyn", name: "Bedford Stuyvesant"},
{borough: "Brooklyn", name: "Bensonhurst"},
{borough: "Brooklyn", name: "Bergen Beach"},
{borough: "Brooklyn", name: "Boerum Hill"},
{borough: "Brooklyn", name: "Borough Park"},
{borough: "Brooklyn", name: "Brighton Beach"},
{borough: "Brooklyn", name: "Brooklyn Heights"},
{borough: "Brooklyn", name: "Brownsville"},
{borough: "Brooklyn", name: "Bushwick"},
{borough: "Brooklyn", name: "Canarsie"},
{borough: "Brooklyn", name: "Carroll Gardens"},
{borough: "Brooklyn", name: "Clinton Hill"},
{borough: "Brooklyn", name: "Cobble Hill"},
{borough: "Brooklyn", name: "Coney Island"},
{borough: "Brooklyn", name: "Crown Heights"},
{borough: "Brooklyn", name: "Ditmas Park"},
{borough: "Brooklyn", name: "Dumbo"},
{borough: "Brooklyn", name: "Dyker Heights"},
{borough: "Brooklyn", name: "East New York"},
{borough: "Brooklyn", name: "Flatbush"},
{borough: "Brooklyn", name: "Flatlands"},
{borough: "Brooklyn", name: "Fort Greene"},
{borough: "Brooklyn", name: "Fort Hamilton"},
{borough: "Brooklyn", name: "Gravesend"},
{borough: "Brooklyn", name: "Greenpoint"},
{borough: "Brooklyn", name: "Kensington"},
{borough: "Brooklyn", name: "Manhattan Beach"},
{borough: "Brooklyn", name: "Midwood"},
{borough: "Brooklyn", name: "Mill Basin"},
{borough: "Brooklyn", name: "Navy Yard"},
{borough: "Brooklyn", name: "Ocean Hill"},
{borough: "Brooklyn", name: "Park Slope"},
{borough: "Brooklyn", name: "Prospect Heights"},
{borough: "Brooklyn", name: "Prospect Lefferts Gardens"},
{borough: "Brooklyn", name: "Red Hook"},
{borough: "Brooklyn", name: "Sheepshead Bay"},
{borough: "Brooklyn", name: "Spring Creek"},
{borough: "Brooklyn", name: "Starrett City"},
{borough: "Brooklyn", name: "Sunset Park"},
{borough: "Brooklyn", name: "Vinegar Hill"},
{borough: "Brooklyn", name: "Williamsburg"},
{borough: "Brooklyn", name: "Windsor Terrace"}])


# neighborhoods = Neighborhood.create([
#     {name: 'Lower Manhattan'}, 
#     {name: 'Tribeca'}, 
#     {name: 'Soho'}, 
#     {name: 'Greenwich Village'}, 
#     {name: 'East Village'}, 
#     {name: 'Lower East Side'}, 
#     {name: 'Nolita and Noho'}, 
#     {name: 'Gramercy Park and Murray Hill'}, 
#     {name: 'Chelsea'}, 
#     {name: 'Midtown East'}, 
#     {name: 'Midtown West and Hells Kitchen'}, 
#     {name: 'Upper East Side'}, 
#     {name: 'Upper West Side'}, 
#     {name: 'Morningside Heights'}, 
#     {name: 'Harlem'}, 
#     {name: 'Hamilton Heights and Washington Heights'}, 
#     {name: 'Brooklyn Heights and Cobble Hill'}, 
#     {name: 'Boerum Hill and Carroll Gardens'}, 
#     {name: 'Red Hook'}, 
#     {name: 'Dumbo'}, 
#     {name: 'Fort Greene and Clinton Hill'}, 
#     {name: 'Park Slope'}, 
#     {name: 'Beyond the Slope'}, 
#     {name: 'Williamsburg and Greenpoint'}, 
#     {name: 'Astoria and Long Island City'}
#     ])

