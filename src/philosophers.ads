package Philosophers is

   -- Initial values
	NO_PHILOSOPHERS : CONSTANT := 5;
	
	protected type Fork is
		entry request;
		procedure give_back;
		private
		is_clean : Boolean := False;
	end Fork;
	
	task type Philosopher (ID: Integer; Left, Right : not null access Fork) is
		entry start_dine;
	end Philosopher;
	
	
	procedure dining_philosophers;

end Philosophers;
