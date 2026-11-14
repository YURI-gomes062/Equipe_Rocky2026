## Manages the vital resources of the outpost.
## Handles daily random energy generation and real-based conversion rates.
extends Node

# Signals
signal resource_changed(resource_name: String, new_value: int)
signal energy_allocation_failed(reason: String)
signal daily_energy_generated(amount: int)

# Constants (The "Real Data" simplified)
const MAX_RESOURCE_VALUE: int = 100
const MIN_RESOURCE_VALUE: int = 0

# Energy variation (Simulating solar/storms)
const MIN_DAILY_ENERGY: int = 40
const MAX_DAILY_ENERGY: int = 100

# Conversion Rates (2 energy = 1 O2 / 2 energy = 1 Food)
const ENERGY_TO_O2_RATE: int = 2
const ENERGY_TO_FOOD_RATE: int = 2

# Crew consumption per day
const CREW_O2_CONSUMPTION: int = 10
const CREW_FOOD_CONSUMPTION: int = 10

# Public Variables
var daily_energy_available: int = 0
var oxygen: int = 100
var food: int = 100
var health: int = 100

# Dictionary tracking allocated energy
var energy_allocations: Dictionary = {
	"oxygen": 0,
	"food": 0,
	"protection": 0,
	"research": 0
}

func _ready() -> void:
	print("[ResourceManager] Initialized.")

## Called by GameManager when a new game starts or a new day begins.
## Generates a random amount of energy for the day.
func generate_daily_energy() -> void:
	daily_energy_available = randi_range(MIN_DAILY_ENERGY, MAX_DAILY_ENERGY)
	
	# Reset allocations at the start of the day
	for key in energy_allocations.keys():
		energy_allocations[key] = 0
		
	print("[ResourceManager] New day energy generated: ", daily_energy_available, "%")
	emit_signal("daily_energy_generated", daily_energy_available)

## Allocates energy to a station. Cannot exceed the daily available energy.
func allocate_energy(station_id: String, percentage: int) -> void:
	if not energy_allocations.has(station_id):
		return
		
	var total_allocated: int = 0
	for value in energy_allocations.values():
		total_allocated += value
		
	var old_value: int = energy_allocations[station_id]
	var new_total: int = total_allocated - old_value + percentage
	
	if new_total > daily_energy_available:
		emit_signal("energy_allocation_failed", "Not enough energy today!")
		return
		
	energy_allocations[station_id] = percentage

## Processes daily consumption based on allocated energy.
func process_turn_resources() -> void:
	# 1. Calculate Oxygen Production and Net Change
	var o2_produced: int = energy_allocations["oxygen"] / ENERGY_TO_O2_RATE
	var o2_net_change: int = o2_produced - CREW_O2_CONSUMPTION
	_update_resource("oxygen", oxygen + o2_net_change)
	
	# 2. Calculate Food Production and Net Change
	var food_produced: int = energy_allocations["food"] / ENERGY_TO_FOOD_RATE
	var food_net_change: int = food_produced - CREW_FOOD_CONSUMPTION
	_update_resource("food", food + food_net_change)
	
	# 3. Check Health Condition
	if oxygen <= 0 or food <= 0:
		# If out of vital resources, health drops by 15
		_update_resource("health", health - 15)
		
	# 4. Research Logic (Optional for Task 03, but good to have)
	# If allocated energy to research, add science points (Task 07).

func _update_resource(resource_name: String, new_value: int) -> void:
	var clamped_value: int = clampi(new_value, MIN_RESOURCE_VALUE, MAX_RESOURCE_VALUE)
	set(resource_name, clamped_value)
	emit_signal("resource_changed", resource_name, clamped_value)
	print("[ResourceManager] ", resource_name, " is now ", clamped_value)
