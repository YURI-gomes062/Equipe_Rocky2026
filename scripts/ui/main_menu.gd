class_name MainMenu
extends Control

# --- ENCAIXES PARA O FRONT-END (Aparecem no Inspetor) ---
@export_group("Botões e Controles")
@export var btn_play: BaseButton
@export var btn_settings: BaseButton
@export var btn_credits: BaseButton
@export var btn_exit: BaseButton
@export var lang_select: OptionButton

@export_group("Caixas / Painéis (Pop-ups)")
@export var panel_settings: Control
@export var panel_credits: Control

@export_group("Configuração de Cenas")
@export_file("*.tscn") var first_level_scene: String = "res://scenes/main_game.tscn"

const LOCALES := ["pt", "en", "es"]

func _ready() -> void:
	# Garante que os painéis extras comecem fechados
	if panel_settings:
		panel_settings.hide()
	if panel_credits:
		panel_credits.hide()

	# Conecta os botões automaticamente se o Front tiver encaixado eles no Inspetor
	if btn_play:
		btn_play.pressed.connect(_on_btn_play_pressed)
	if btn_settings:
		btn_settings.pressed.connect(_on_btn_settings_pressed)
	if btn_credits:
		btn_credits.pressed.connect(_on_btn_credits_pressed)
	if btn_exit:
		if OS.has_feature("web"):
			btn_exit.hide()
		else:
			btn_exit.pressed.connect(_on_btn_exit_pressed)

	# Configura o seletor de idiomas
	if lang_select:
		_setup_language_selector()

func _setup_language_selector() -> void:
	lang_select.clear()
	lang_select.add_item("Português")
	lang_select.add_item("English")
	lang_select.add_item("Español")
	
	var current_locale := TranslationServer.get_locale().left(2)
	var idx := LOCALES.find(current_locale)
	if idx != -1:
		lang_select.select(idx)
		
	lang_select.item_selected.connect(_on_lang_select_item_selected)

# --- AÇÕES DO MENU ---

func _on_btn_play_pressed() -> void:
	if first_level_scene != "":
		get_tree().change_scene_to_file(first_level_scene)

func _on_btn_settings_pressed() -> void:
	if panel_settings:
		panel_settings.visible = !panel_settings.visible
		if panel_credits:
			panel_credits.hide()

func _on_btn_credits_pressed() -> void:
	if panel_credits:
		panel_credits.visible = !panel_credits.visible
		if panel_settings:
			panel_settings.hide()

func _on_btn_exit_pressed() -> void:
	get_tree().quit()

func _on_lang_select_item_selected(index: int) -> void:
	if index >= 0 and index < LOCALES.size():
		TranslationServer.set_locale(LOCALES[index])
