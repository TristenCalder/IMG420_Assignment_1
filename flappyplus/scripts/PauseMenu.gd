extends CanvasLayer
signal restart_requested

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	%Resume.pressed.connect(_on_resume)
	%Restart.pressed.connect(_on_restart)
	%Quit.pressed.connect(_on_quit)

func open():  visible = true;  get_tree().paused = true
func close(): visible = false; get_tree().paused = false

func _on_resume(): close()
func _on_restart(): close(); restart_requested.emit()
func _on_quit(): get_tree().paused = false; get_tree().quit()
