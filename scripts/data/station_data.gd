## Defines the structure for a station in the outpost.
class_name StationData extends Resource

@export_group("Station Details")
## The translation key for the station name (e.g., "STATION_OXYGEN").
@export var station_name_key: String = "STATION_NEW"

@export_group("Energy Configuration")
## The minimum energy percentage required (0 to 100).
@export_range(0, 100) var min_energy_required: int = 20
## The resource this station produces.
@export_enum("Oxygen", "Food", "Protection", "Research", "None") var resource_produced: String = "None"
