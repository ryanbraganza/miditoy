extends Node2D

var lines = []
@onready var connected_inputs_label: RichTextLabel = %ConnectedInputsLabel
@onready var midi_events_label: RichTextLabel = %MidiEventsLabel

func _ready():
	OS.open_midi_inputs()

func _process(_delta):
	# Need to poll the connected midi inputs because they are set asynchronously after open_midi_inputs() is called
	var connected_inputs = OS.get_connected_midi_inputs()
	connected_inputs_label.text = 'Connected inputs: %s\n' % connected_inputs.size()
	connected_inputs_label.text += '\n'.join(connected_inputs)

func _input(input_event):
	if input_event is InputEventMIDI:
		print(input_event)

		midi_events_label.text += str(input_event) + '\n'
		#lines.append(str(input_event))
		#lines = lines.slice(-10)
		#midi_events_label.text = '\n'.join(lines)
	elif input_event is InputEventKey:
		if input_event.as_text_keycode() == 'Enter':
			print('ok')
			OS.close_midi_inputs()
		elif input_event.as_text_keycode() == 'Space':
			print('start again')
			OS.open_midi_inputs()

func _exit_tree():
	OS.close_midi_inputs()
