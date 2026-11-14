## Manages random events using a Pity System (probability increases if no event occurs).
extends Node

# Signals
## Emitted when an event is triggered, passing the event data to the UI.
signal event_triggered(event_data: EventData)
## Emitted when an event is fully resolved.
signal event_resolved()

# Constants
const EVENTS_PATH: String = "res://data/events/"
const BASE_CHANCE: int = 20
const CHANCE_INCREMENT: int = 10

# Private Variables
var _event_chance: int = BASE_CHANCE
var _current_event: EventData = null

# Public Methods
## Checks if an event should trigger.
## Returns true if an event was triggered, false otherwise.
func check_for_event() -> bool:
	var roll: int = randi_range(1, 100)
	
	if roll <= _event_chance:
		# Event triggers!
		_event_chance = BASE_CHANCE # Reset chance
		_current_event = _load_random_event()
		
		if _current_event != null:
			emit_signal("event_triggered", _current_event)
			return true
		else:
			return false
	else:
		# No event, increase chance for next time
		_event_chance += CHANCE_INCREMENT
		# Cap the chance at 100%
		_event_chance = mini(_event_chance, 100) 
		print("[EventManager] No event. Next chance: ", _event_chance, "%")
		return false

## Resolves the player's choice and applies the effects.
func resolve_event_choice(choice_index: int) -> void:
	if _current_event == null:
		return
		
	if choice_index >= 0 and choice_index < _current_event.choices.size():
		var choice: ChoiceData = _current_event.choices[choice_index]
		
		# Apply all effect fragments in the chosen choice
		for effect in choice.effects:
			ResourceManager.apply_effect(effect)
			
		print("[EventManager] Event resolved with choice: ", choice.choice_text_key)
		
	# Clear the current event and notify
	_current_event = null
	emit_signal("event_resolved")

# Private Methods
## Loads a random .tres file from the events directory.
func _load_random_event() -> EventData:
	var dir: DirAccess = DirAccess.open(EVENTS_PATH)
	if dir == null:
		push_error("Could not open events directory: " + EVENTS_PATH)
		return null
		
	var files: PackedStringArray = dir.get_files()
	# Filter only .tres files
	var tres_files: Array[String] = []
	for file in files:
		if file.ends_with(".tres"):
			tres_files.append(file)
			
	if tres_files.is_empty():
		push_warning("No event files found in " + EVENTS_PATH)
		return null
		
	var random_index: int = randi_range(0, tres_files.size() - 1)
	var event_path: String = EVENTS_PATH + tres_files[random_index]
	
	return load(event_path) as EventData
