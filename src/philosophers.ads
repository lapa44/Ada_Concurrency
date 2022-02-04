package Philosophers is

   -- Initial values
	NO_PHILOSOPHERS : CONSTANT := 5;
	
	-- Protected type Fork which is securing concurrency
	protected type Fork is
		entry request;
		procedure give_back;
		private
		is_clean : Boolean := False;
	end Fork;
	
	-- task/thread of a Philosohper
	task type Philosopher (ID: Integer; Left, Right : not null access Fork) is
		entry start_dine;
	end Philosopher;
	
	-- Procedure which is executing example of dining philosophers solution
	procedure dining_philosophers;

end Philosophers;
