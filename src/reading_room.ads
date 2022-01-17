package Reading_Room is

	NO_READERS : CONSTANT Integer := 7;
	NO_WRITERS : CONSTANT Integer := 2;
	DELAY_MULTIPLIER : CONSTANT := 2; -- For writers, readers has delay equal to their id
	procedure open_reading_room;
	

end Reading_Room;
