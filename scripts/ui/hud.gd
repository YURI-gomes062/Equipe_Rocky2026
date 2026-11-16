## Manages the top HUD, displaying resource bars and the next day button.
## Reacts to signals from ResourceManager and GameManager.
extends CanvasLayer

# Constants
const WARNING_THRESHOLD: int = 30

# Node References (Using get_node_or_null to prevent crashes if nodes are missing)
@onready var energy_bar: TextureProgressBar = get_node_or_null("HUDRoot/MarginContainer/HBoxContainer/EnergyContainer/EnergyBar")
@onready var o2_bar: TextureProgressBar = get_node_or_null("HUDRoot/MarginContainer/HBoxContainer/O2Container/O2Bar")
@onready var food_bar: TextureProgressBar = get_node_or_null("HUDRoot/MarginContainer/HBoxContainer/ResourceContainer/ResourceBar")
@onready var radiation_bar: TextureProgressBar = get_node_or_null("HUDRoot/MarginContainer/HBoxContainer/RadiationContainer2/RadiationBar")
@onready var next_day_button: TextureButton = get_node_or_null("HUDRoot/NextDayButton")
@onready var day_label: Label = get_node_or_null("HUDRoot/DayLabel")

# Godot Native Methods
func _ready() -> void:
	# Connect ResourceManager signals
	ResourceManager.resource_changed.connect(_on_resource_changed)
	ResourceManager.daily_energy_generated.connect(_on_daily_energy_generated)
	
	# Connect GameManager signals
	GameManager.day_advanced.connect(_on_day_advanced)
	GameManager.game_started.connect(_on_game_started)
	GameManager.state_changed.connect(_on_game_state_changed)
	
	# Connect UI Button safely
	if next_day_button:
		next_day_button.pressed.connect(_on_next_day_button_pressed)
	
	# Initialize UI
	_sync_all_bars()
	_update_day_label(GameManager.current_day)

# Signal Callbacks (Public Methods)
func _on_resource_changed(resource_name: String, new_value: int) -> void:
	match resource_name:
		"oxygen":
			if o2_bar: _animate_bar(o2_bar, new_value); _flash_warning(o2_bar, new_value)
		"food":
			if food_bar: _animate_bar(food_bar, new_value); _flash_warning(food_bar, new_value)
		"radiation":
			if radiation_bar: _animate_bar(radiation_bar, new_value); _flash_warning(radiation_bar, new_value)

func _on_daily_energy_generated(amount: int) -> void:
	if energy_bar: _animate_bar(energy_bar, amount)

func _on_day_advanced(current_day: int) -> void:
	_update_day_label(current_day)

func _on_game_started() -> void:
	_sync_all_bars()
	_update_day_label(1)

func _on_game_state_changed(new_state: int) -> void:
	if next_day_button == null: return
	
	if new_state == GameManager.GameState.PLAYING:
		next_day_button.disabled = false
		next_day_button.modulate = Color(1, 1, 1, 1)
	else:
		next_day_button.disabled = true
		next_day_button.modulate = Color(0.5, 0.5, 0.5, 0.5)

func _on_next_day_button_pressed() -> void:
	GameManager.advance_day()

# Private Methods
func _sync_all_bars() -> void:
	if energy_bar: energy_bar.value = ResourceManager.daily_energy_available
	if o2_bar: o2_bar.value = ResourceManager.oxygen
	if food_bar: food_bar.value = ResourceManager.food
	# if radiation_bar: radiation_bar.value = ResourceManager.radiation (quando implementar)

func _animate_bar(bar: TextureProgressBar, target_value: int) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(bar, "value", target_value, 0.3).set_trans(Tween.TRANS_SINE)

func _flash_warning(bar: TextureProgressBar, value: int) -> void:
	if value <= WARNING_THRESHOLD:
		var tween: Tween = create_tween()
		for i in range(3):
			tween.tween_property(bar, "modulate", Color(1, 0.3, 0.3, 1), 0.1)
			tween.tween_property(bar, "modulate", Color(1, 1, 1, 1), 0.1)
	else:
		bar.modulate = Color(1, 1, 1, 1)

func _update_day_label(current_day: int) -> void:
	if day_label != null:
		day_label.text = "%s: %d / %d" % [tr("UI_SOL"), current_day, GameManager.MAX_DAYS]
