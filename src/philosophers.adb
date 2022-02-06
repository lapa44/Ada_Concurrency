with Ada.Text_IO; use Ada.Text_IO;

package body Philosophers is

	protected body Fork is
		procedure request (id : Integer) is
		begin
			if is_clean then
				-- Fork is kept as it's clean
				null;
			else
				-- Cleaning up and handing fork over
				is_clean := True;
				owner_id := id;
				end if;
		end request;
		
		procedure give_back is
		begin
			  is_clean := False;
		end give_back;
		
		function is_fork_clean return Boolean is
		begin
			return is_clean;
		end is_fork_clean;
		
		function am_I_owner (id : Integer) return Boolean is
		begin
			return owner_id = id;
		end;
	end Fork;
	
	task body Philosopher is
		procedure eating is
		begin
			if Left.is_fork_clean and Right.is_fork_clean 
			and Left.am_I_owner(ID) and Right.am_I_owner(ID) then
				Put_Line ("Philosopher #" & ID'Image & " is eating.");
			end if;
		end eating;
	begin
		accept start_dine do
			Put_Line("Philosopher #" & ID'Image & "  came to the table.");
		end start_dine;
		loop
			Put_Line ("Philosopher #" & ID'Image & " is thinking.");
			delay Duration(ID);
			Put_Line ("Philosopher #" & ID'Image & " is hungry.");
			Left.request(ID);
			Right.request(ID);
			eating;
			--delay Duration(ID);
			Left.give_back;
			Right.give_back;
		end loop;
	end Philosopher;
	
	procedure dining_philosophers is
			Forks_arr : array (1 .. NO_PHILOSOPHERS) of aliased Fork;
		Ph1 : Philosopher(1, Forks_arr(1)'Access, Forks_arr(2)'Access);
		Ph2 : Philosopher(2, Forks_arr(2)'Access, Forks_arr(3)'Access);
		Ph3 : Philosopher(3, Forks_arr(3)'Access, Forks_arr(4)'Access);
		Ph4 : Philosopher(4, Forks_arr(4)'Access, Forks_arr(5)'Access);
		Ph5 : Philosopher(5, Forks_arr(5)'Access, Forks_arr(1)'Access);
		
		begin
			Put_Line("I know that I know nothing ~Socrates");
		Ph1.start_dine;
		Ph2.start_dine;
		Ph3.start_dine;
		Ph4.start_dine;
		Ph5.start_dine;
				
		end dining_philosophers;

end Philosophers;
