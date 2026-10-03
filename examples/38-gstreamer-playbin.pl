% PLGI example: play an audio file or stream URL with GStreamer playbin.
%
% Usage:
%   swipl examples/38-gstreamer-playbin.pl -- /path/to/audio.mp3
%   swipl examples/38-gstreamer-playbin.pl -- https://example.com/stream.mp3
%
% Copyright (C) GNU Free Documentation License 1.3
% This file is distributed under the same license as the Python GTK+ 3 Tutorial package.
% Samer Abdallah, 2026.



:- use_module(library(plgi)).

:- plgi_use_namespace('Gst', '1.0').

main :-
	current_prolog_flag(argv, Argv),
	(   Argv = [Media]
	->  true
	;   format(user_error, 'Usage: swipl <this-file> -- <audio-file-or-url>~n', []),
	    halt(1)
	),
	(   sub_atom(Media, _, _, _, '://')
	->  Uri = Media
	;   gst_filename_to_uri(Media, Uri)
	),
	gst_init({null}, _),
	atom_concat('playbin uri=', Uri, Launch),
	gst_parse_launch(Launch, Pipeline),
	gst_element_set_state(Pipeline, 'GST_STATE_PLAYING', _),
	gst_element_get_bus(Pipeline, Bus),
	gst_bus_timed_pop_filtered(Bus, 18446744073709551615,
	                           ['GST_MESSAGE_EOS', 'GST_MESSAGE_ERROR'], Message),
	plgi_struct_get_field(Message, type, Type),
	(   Type = ['GST_MESSAGE_EOS']
	->  format('End of stream.~n', [])
	;   gst_message_parse_error(Message, _Error, Debug),
	    format(user_error, 'Playback error: ~w~n', [Debug])
	),
	gst_element_set_state(Pipeline, 'GST_STATE_NULL', _),
	halt.

:- main.
