extends CanvasLayer

@onready var speech_bubble: PanelContainer = $AnchorRoot/BottomLeftHUD/SpeechBubble
@onready var message_label: RichTextLabel = $AnchorRoot/BottomLeftHUD/SpeechBubble/MarginContainer/VBoxContainer/MessageLabel
@onready var next_button: Button = $AnchorRoot/BottomLeftHUD/SpeechBubble/MarginContainer/VBoxContainer/NextButton
@onready var robo_avatar: TextureRect = $AnchorRoot/BottomLeftHUD/RoboAvatar

# Chaves de tradução do tutorial (ou textos diretos enquanto testa)
var tutorial_steps: Array[String] = [
	"TUTORIAL_STEP_1",
	"TUTORIAL_STEP_2",
	"TUTORIAL_STEP_3",
	"TUTORIAL_STEP_4"
]

var _current_step: int = 0
var _is_tutorial: bool = false
var _typing_tween: Tween

func _ready() -> void:
	layer = 20
	speech_bubble.hide()
	next_button.pressed.connect(_on_next_pressed)
	_start_idle_float()
	
	# Inicia o tutorial automaticamente para você testar
	start_tutorial()

# --- TUTORIAL PASSO A PASSO ---
func start_tutorial() -> void:
	_is_tutorial = true
	_current_step = 0
	next_button.show()
	_show_text(tr(tutorial_steps[_current_step]), Color.WHITE)

func _on_next_pressed() -> void:
	_current_step += 1
	if _current_step < tutorial_steps.size():
		_show_text(tr(tutorial_steps[_current_step]), Color.WHITE)
	else:
		_is_tutorial = false
		speech_bubble.hide()

# --- ALERTAS DE PERIGO E REPAROS ---
func warn_danger(danger_key: String, sector_key: String = "") -> void:
	if _is_tutorial:
		return
		
	next_button.hide()
	var msg := tr(danger_key)
	if sector_key != "":
		msg = msg.replace("{sector}", tr(sector_key))
		
	_show_text(msg, Color(1.0, 0.75, 0.7))
	
	await get_tree().create_timer(6.0).timeout
	if not _is_tutorial:
		speech_bubble.hide()

# --- EFEITO DE DIGITAÇÃO ---
func _show_text(text: String, bubble_color: Color) -> void:
	speech_bubble.show()
	speech_bubble.self_modulate = bubble_color
	message_label.text = text
	message_label.visible_ratio = 0.0
	
	if _typing_tween and _typing_tween.is_running():
		_typing_tween.kill()
		
	_typing_tween = create_tween()
	var duration := clampf(text.length() * 0.025, 0.4, 1.8)
	_typing_tween.tween_property(message_label, "visible_ratio", 1.0, duration)

# Flutuação suave do robô
func _start_idle_float() -> void:
	var t := create_tween().set_loops()
	t.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	t.tween_property(robo_avatar, "position:y", robo_avatar.position.y - 5.0, 1.2)
	t.tween_property(robo_avatar, "position:y", robo_avatar.position.y + 5.0, 1.2)
