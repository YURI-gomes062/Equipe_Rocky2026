## Defines a single choice the player can make during an event.
class_name ChoiceData extends Resource

## The translation key for the button text (e.g., "CHOICE_DEFLECT").
@export var choice_text_key: String = "CHOICE_DEFAULT"
## The list of effects this choice will trigger.
@export var effects: Array[EffectData] = []
