## Manages the main map UI interactions.
## Handles the hover effect (zoom and dark overlay) for the outpost rooms.
extends Control

# Node References (Using @onready to get them when the scene loads)
@onready var dark_overlay: ColorRect = $DarkOverlay
@onready var room_buttons: Array[TextureButton] = [
	$Control/TextureButton,   # Room 1 (e.g., Greenhouse)
	$Control/TextureButton2,  # Room 2 (e.g., Life Support)
	$Control/TextureButton3,  # Room 3 (e.g., Solar Panels)
	$Control/TextureButton4   # Room 4 (e.g., Research)
]

@onready var station_popup_scene: PackedScene = preload("res://scenes/ui/StationPopup.tscn")
var _station_popup_instance: PopupPanel

# Constants
const HOVER_SCALE_FACTOR: float = 1.15
const ANIMATION_DURATION: float = 0.2
const HOVER_Z_INDEX: int = 10

# Private Variables
# Dictionary to store the original scale of each button before hovering
var _original_scales: Dictionary = {}

# Godot Native Methods
func _ready() -> void:
	# Ensure the dark overlay starts hidden
	dark_overlay.visible = false
	
	_station_popup_instance = station_popup_scene.instantiate()
	add_child(_station_popup_instance)
	
	room_buttons[0].pressed.connect(_on_room_pressed.bind("food", "STATION_FOOD"))
	room_buttons[1].pressed.connect(_on_room_pressed.bind("oxygen", "STATION_OXYGEN"))
	room_buttons[2].pressed.connect(_on_room_pressed.bind("research", "STATION_RESEARCH"))
	room_buttons[3].pressed.connect(_on_room_pressed.bind("protection", "STATION_PROTECTION"))
	
	# Connect signals for all room buttons
	for button in room_buttons:
		if button != null:
			# Save the original scale so we can return to it later
			_original_scales[button] = button.scale
			
			# Connect mouse events
			button.mouse_entered.connect(_on_room_mouse_entered.bind(button))
			button.mouse_exited.connect(_on_room_mouse_exited.bind(button))

# Private Methods
## Handles the mouse entering a room.
func _on_room_mouse_entered(button: TextureButton) -> void:
	# 1. Show the dark overlay to focus on the room
	dark_overlay.visible = true
	
	# 2. Bring the button to the front so it's above the dark overlay
	button.z_index = HOVER_Z_INDEX
	
	# 3. Create a smooth zoom-in animation
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	var target_scale: Vector2 = _original_scales[button] * HOVER_SCALE_FACTOR
	tween.tween_property(button, "scale", target_scale, ANIMATION_DURATION)

## Handles the mouse leaving a room.
func _on_room_mouse_exited(button: TextureButton) -> void:
	# 1. Hide the dark overlay
	dark_overlay.visible = false
	
	# 2. Reset the z_index
	button.z_index = 0
	
	# 3. Create a smooth zoom-out animation
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(button, "scale", _original_scales[button], ANIMATION_DURATION)

func _on_room_pressed(station_id: String, name_key: String) -> void:
	GameManager.pause_game()
	_station_popup_instance.setup(station_id, name_key)
	_station_popup_instance.popup_centered()
	
