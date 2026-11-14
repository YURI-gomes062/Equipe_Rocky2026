extends Node

const SUPPORTED_LOCALES = ["pt", "en", "es"]
const DEFAULT_LOCALE = "en"

func _ready() -> void:
	detect_and_set_locale()

func detect_and_set_locale() -> void:
	var raw_locale := ""
	
	if OS.has_feature("web"):
		var js_lang = JavaScriptBridge.eval("navigator.language || navigator.userLanguage")
		if js_lang != null:
			raw_locale = str(js_lang)
	else:
		raw_locale = OS.get_locale()
	
	var short_locale := raw_locale.left(2).to_lower()
	
	if short_locale in SUPPORTED_LOCALES:
		TranslationServer.set_locale(short_locale)
	else:
		TranslationServer.set_locale(DEFAULT_LOCALE)
