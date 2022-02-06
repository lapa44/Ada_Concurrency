package Philosophers is

   -- Initial values
	NO_PHILOSOPHERS : CONSTANT := 5;
	
	-- Protected type Fork which is securing concurrency
	protected type Fork is
		procedure request (id : Integer);
		procedure give_back;
		function is_fork_clean return Boolean;
		function am_I_owner (id : Integer) return Boolean;
		private
		is_clean : Boolean := False;
		owner_id : Integer;
	end Fork;
	
	-- task/thread of a Philosohper
	task type Philosopher (ID: Integer; Left, Right : not null access Fork) is
		entry start_dine;
		--procedure eating;
	end Philosopher;
	
	-- Procedure which is executing example of dining philosophers solution
	procedure dining_philosophers;

end Philosophers;
