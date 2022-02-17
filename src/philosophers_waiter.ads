package Philosophers_waiter is

	protected type Fork is
		entry grab;
		procedure give_back;
	private
		owned : Boolean := False;
	end Fork;
	
	-- Waiter will ensure there are max 4 dining philosophers at the time
	-- what means, there will be not deadlock and picking order doesn't matter
	protected Waiter is
		entry try_eating;
		procedure stop_eating;
	private
		eating_philosophers : Integer := 0;
	end Waiter;
	
	task type Philosopher (ID : Integer; Left, Right : not null access Fork);
	
	procedure dining_room;
	
end Philosophers_waiter;
