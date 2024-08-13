extends Node2D



var lines = []

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(input_event):
	if input_event is InputEventMIDI:
		_print_midi_info(input_event)
		lines.append((JSON.stringify(input_event)))
		lines = lines.slice(-10)

		%RichTextLabel.text = lines.reduce(func(a, b): return a + '\n' + b)
	elif input_event is InputEventKey:
		if input_event.as_text_keycode() == 'Enter':
			print('ok')
			OS.close_midi_inputs()
		elif input_event.as_text_keycode() == 'Space':
			print('start again')
			OS.open_midi_inputs()



func _exit_tree():
	OS.close_midi_inputs()

func _print_midi_info(midi_event):
	print(midi_event)
