extends Node

const PATH := "user://settings.cfg"

var locale: String = "pt_BR"
var fullscreen: bool = false


func _ready() -> void:
	load_settings()
	TranslationServer.set_locale(locale)
	# Na web, tela cheia só funciona após um clique, então não aplicamos no início.
	if not OS.has_feature("web"):
		_apply_fullscreen(fullscreen)


func set_locale(value: String) -> void:
	locale = value
	TranslationServer.set_locale(value)


func set_fullscreen(value: bool) -> void:
	fullscreen = value
	_apply_fullscreen(value)


func _apply_fullscreen(value: bool) -> void:
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if value
		else DisplayServer.WINDOW_MODE_WINDOWED)


func save_settings() -> void:
	var c := ConfigFile.new()
	c.set_value("game", "locale", locale)
	c.set_value("video", "fullscreen", fullscreen)
	c.save(PATH)


func load_settings() -> void:
	var c := ConfigFile.new()
	if c.load(PATH) != OK:
		return
	locale = c.get_value("game", "locale", locale)
	fullscreen = c.get_value("video", "fullscreen", fullscreen)
