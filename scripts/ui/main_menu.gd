extends Control

# Se o game.tscn estiver em outra pasta, apague o caminho abaixo e arraste
# o arquivo do painel Arquivos para dentro dos parênteses do preload.
const GAME_SCENE: PackedScene = preload("res://scenes/game.tscn")

@onready var btn_start: Button = $VBoxContainer/BtnStart
@onready var btn_settings: Button = $VBoxContainer/BtnSettings
@onready var btn_exit: Button = $VBoxContainer/BtnExit
@onready var panel_settings: Panel = $PanelSettings


func _ready() -> void:
	panel_settings.visible = false
	btn_exit.visible = not OS.has_feature("web")  # sair não faz sentido no navegador

	btn_start.pressed.connect(_on_start_pressed)
	btn_settings.pressed.connect(_on_settings_pressed)
	btn_exit.pressed.connect(_on_exit_pressed)

	# Botão "Exit" dentro do painel de settings: fecha o painel
	var btn_close := panel_settings.get_node_or_null("Exit") as Button
	if btn_close:
		btn_close.pressed.connect(_close_settings)

	# Botões de idioma dentro do painel de settings
	_connect_language_button("BtnPt", "pt")
	_connect_language_button("BtnEn", "en")
	_connect_language_button("BtnEs", "es")

	btn_start.grab_focus()


func _connect_language_button(node_name: String, code: String) -> void:
	var btn := panel_settings.get_node_or_null("HBoxLanguages/" + node_name) as Button
	if btn:
		btn.pressed.connect(_set_language.bind(code))
	else:
		push_warning("Botao de idioma nao encontrado: " + node_name)


func _set_language(code: String) -> void:
	Settings.set_locale(code)
	Settings.save_settings()


func _on_start_pressed() -> void:
	print("Start apertado")
	var err := get_tree().change_scene_to_packed(GAME_SCENE)
	if err != OK:
		push_error("Falha ao trocar de cena. Código de erro: " + str(err))


func _on_settings_pressed() -> void:
	panel_settings.visible = true


func _close_settings() -> void:
	panel_settings.visible = false
	btn_settings.grab_focus()


func _on_exit_pressed() -> void:
	get_tree().quit()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and panel_settings.visible:
		_close_settings()
		get_viewport().set_input_as_handled()
