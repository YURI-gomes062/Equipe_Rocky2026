## Defines the structure for a random event in the game.
class_name EventData extends Resource

@export_group("Event Details")
## The translation key for the title (e.g., "EVENT_METEOR_TITLE").
@export var title_key: String = "EVENT_NEW_TITLE"
## The translation key for the description (e.g., "EVENT_METEOR_DESC").
@export_multiline var description_key: String = "EVENT_NEW_DESC"

@export_group("Player Choices")
## The list of choices the player can make. Usually 2.
@export var choices: Array[ChoiceData] = []
