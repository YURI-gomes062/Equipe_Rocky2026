## Manages the global game flow, state, and day transition.
## Also handles pausing the game when UI popups (Stations, Diary) are open.
extends Node

# Signals
signal game_started()
signal day_advanced(current_day: int)
signal game_over(is_victory: bool)
## Emitted whenever the game state changes (useful for UI to update buttons).
signal state_changed(new_state: GameState)

# Enums
enum GameState {
	MENU,        # On the main menu
	PLAYING,     # Game is running normally
	PAUSED,      # User opened a popup (Station, Diary) or paused the game
	EVENT,       # A mandatory event popup is showing
	GAME_OVER    # Victory or Defeat
}

# Constants
const MAX_DAYS: int = 18

# Public Variables
var current_state: GameState = GameState.MENU
var current_day: int = 1

# Private Variables
var _is_game_over_triggered: bool = false

# Public Methods
## Starts a new game session. Called by the Main Menu "Start" button.
func start_game() -> void:
	current_day = 1
	_is_game_over_triggered = false
	_set_state(GameState.PLAYING)
	get_tree().paused = false 
	
	# Reset base resources
	ResourceManager.oxygen = 100
	ResourceManager.food = 100
	ResourceManager.health = 100
	
	# Generate energy for Day 1
	ResourceManager.generate_daily_energy()
	
	print("[GameManager] New game started. Day 1.")
	emit_signal("game_started")

## Advances the game to the next day. Only works if the game is currently PLAYING.
func advance_day() -> void:
	if current_state != GameState.PLAYING:
		return
		
	current_day += 1
	print("[GameManager] Day advanced to: ", current_day)
	
	# 1. Process resources for the day that just ended
	ResourceManager.process_turn_resources()
	
	# 2. Check Defeat Condition (Health reached 0)
	if ResourceManager.health <= 0:
		_trigger_game_over(false)
		return
		
	# 3. Check Victory Condition (Survived 18 days)
	if current_day >= MAX_DAYS:
		_trigger_game_over(true)
		return
	
	# 4. If the game continues, generate energy for the NEW day
	ResourceManager.generate_daily_energy()
	
	# 5. Notify UI that the day has successfully advanced
	emit_signal("day_advanced", current_day)
	
	# 6. Check for Random Events for the new day
	if EventManager.check_for_event():
		trigger_event() # Changes state to EVENT and pauses the tree

## Pauses the game and changes state. Called when opening Station popups or Diary.
func pause_game() -> void:
	if current_state == GameState.GAME_OVER or current_state == GameState.MENU:
		return
		
	_set_state(GameState.PAUSED)
	get_tree().paused = true
	print("[GameManager] Game Paused.")

## Resumes the game. Called when closing popups.
func resume_game() -> void:
	if current_state != GameState.PAUSED:
		return
		
	_set_state(GameState.PLAYING)
	get_tree().paused = false
	print("[GameManager] Game Resumed.")

## Triggers a mandatory event. 
func trigger_event() -> void:
	if current_state != GameState.PLAYING:
		return
		
	_set_state(GameState.EVENT)
	get_tree().paused = true

## Resolves an event and resumes the game.
func resolve_event() -> void:
	if current_state != GameState.EVENT:
		return
		
	_set_state(GameState.PLAYING)
	get_tree().paused = false

# Private Methods
func _set_state(new_state: GameState) -> void:
	current_state = new_state
	emit_signal("state_changed", current_state)

## Safely triggers the game over state, ensuring it only happens once.
func _trigger_game_over(is_victory: bool) -> void:
	if _is_game_over_triggered:
		return
		
	_is_game_over_triggered = true
	_set_state(GameState.GAME_OVER)
	get_tree().paused = true # Stop background logic
	
	if is_victory:
		print("[GameManager] GAME OVER: Victory!")
	else:
		print("[GameManager] GAME OVER: Defeat!")
		
	emit_signal("game_over", is_victory)
