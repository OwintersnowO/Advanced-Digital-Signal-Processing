%input parameter
Do = 261.63;
name = 'Hua Dan.wav';
%prefix: - for lower octave, 1 for higher octave
note = [2, 2, 2, 3, 2, -6, 2, 2, 2, 2, 3, 2, 1, -6, -6,0, 2, 2, 3, 2 , 0, 2, 2, 3, 5, 6, 5, 0, 11, 11, 6, 5, 3, 2, 3, 5];
meter = 1;
beat = [0.25, 0.25, 0.25, 0.25, 0.5, 0.5, 2, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.5, 2, 0.25, 0.25, 0.25, 0.25, 1, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.5, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.5, 1.5];
amplitude = [0.5, 0.5, 0.5, 0.5, 0.5, 0.4, 0.5, 0.5, 0.5, 1, 1, 0.4, 0.4, 0.5, 0.8, 0, 0.9, 0.9, 1, 1, 0, 0.8, 0.8, 0.9, 0.9, 0.9, 0.9, 1, 1, 1, 1, 1, 0.9, 0.9, 0.9, 1];

%pameter
fs = 44100;
space = 0.15;

%convert the numbered musical notation (note) into a music siganl (song)
song = [];
temp = 0;
for i = 1:size(note,2)
	%add a spacing if the note is the same as the previous note
	if note(i) == temp
		tp = 0:1/fs:meter*beat(i)*space
		ts = 0:1/fs:meter*beat(i)*(1-space)
		song = [song 0*tp amplitude(i)*chord(note(i), ts, Do)];
	else
		t = 0:1/fs:meter*beat(i)
		song = [song amplitude(i)*chord(note(i), t, Do)];
	end
end

%ouput music file
audiowrite(name, song, fs);

%add chord phonomenon, input1 for note, input2 for time
function c = chord(input1, input2,Do)
	c = sin(2*pi*key(input1,Do)*input2) + 0.3*sin(2*pi*key(input1,Do)*input2*2) + 0.1*sin(2*pi*key(input1,Do)*input2*3) ;
end

%determine the key of the note
function k = key(input,Do)
	scale = [1 1.5 2 2.5 3 4 4.5 5 5.5 6 6.5 7];
	temp = 0;
	if input<0
		temp = temp-12;
		input = 0-input;
    elseif input>10
		temp = temp+12;
		input = input-10;
	end
	for i=1:12
		if input == scale(i)
			temp = (temp+i-1)/12;
		end
	end
	k = Do*2^temp;
end