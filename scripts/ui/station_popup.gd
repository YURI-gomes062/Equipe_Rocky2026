## Manages the station popup UI.
## Allows the player to allocate energy using a slider.
extends PopupPanel

@onready var title_label: Label = $MarginContainer/VBoxContainer/TitleLabel
@onready var energy_label: Label = $MarginContainer/VBoxContainer/EnergyLabel
@onready var energy_slider: HSlider = $MarginContainer/VBoxContainer/EnergySlider
@onready var close_button: Button = $MarginContainer/VBoxContainer/CloseButton

var _current_station_id: String = ""

func _ready() -> void:
	# Connect signals
	energy_slider.value_changed.connect(_on_slider_value_changed)
	close_button.pressed.connect(_on_close_pressed)
	popup_hide.connect(_on_popup_hide)

## Sets up the popup before showing it.
func setup(station_id: String, display_name_key: String) -> void:
	_current_station_id = station_id
	
	# Translate the title using the key (e.g., "STATION_OXYGEN")
	title_label.text = tr(display_name_key)
	
	# Get the max energy available for today
	var max_energy: int = ResourceManager.daily_energy_available
	energy_slider.max_value = max_energy
	
	# Get the current allocation for this specific station
	var current_allocation: int = ResourceManager.energy_allocations[station_id]
	energy_slider.value = current_allocation
	
	# Update the label (using tr() for localization if needed)
	energy_label.text = tr("UI_ENERGY_TODAY") + ": %d%%" % max_energy

func _on_slider_value_changed(value: float) -> void:
	ResourceManager.allocate_energy(_current_station_id, int(value))

func _on_close_pressed() -> void:
	hide()

func _on_popup_hide() -> void:
	GameManager.resume_game()
