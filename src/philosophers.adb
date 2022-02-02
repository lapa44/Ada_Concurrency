with Ada.Text_IO; use Ada.Text_IO;

package body Philosophers is

	protected body Fork is
		entry request when not is_clean is
		begin
			is_clean := True;
		end request;
		
		procedure give_back is
		begin
			is_clean := False;
		end give_back;
	end Fork;
	
	task body Philosopher is
	begin
		accept start_dine do
			Put_Line("Philosopher #" & ID'Image & "  came to the table.");
		end start_dine;
		loop
				Put_Line ("Philosopher #" & ID'Image & " is thinking.");
				delay Duration(ID);
				Put_Line ("Philosopher #" & ID'Image & " is hungry.");
				Left.request;
				Right.request;
				Put_Line ("Philosopher #" & ID'Image & " is eating.");
				delay Duration(ID);
				Left.give_back;
				Right.give_back;
			end loop;
	end Philosopher;
	
	procedure dining_philosophers is
			Forks_arr : array (1 .. NO_PHILOSOPHERS) of aliased Fork;
		--Philosophers_arr : array (1 .. NO_PHILOSOPHERS) of Philosopher;
		Ph1 : Philosopher(1, Forks_arr(1)'Access, Forks_arr(2)'Access);
		Ph2 : Philosopher(2, Forks_arr(2)'Access, Forks_arr(3)'Access);
		Ph3 : Philosopher(3, Forks_arr(3)'Access, Forks_arr(4)'Access);
		Ph4 : Philosopher(4, Forks_arr(4)'Access, Forks_arr(5)'Access);
		Ph5 : Philosopher(5, Forks_arr(5)'Access, Forks_arr(1)'Access);
		
		begin
			Put_Line("I know that I know nothing ~Socrates");
			--for index in 1 .. NO_PHILOSOPHERS-1 loop
				--Philosophers_arr(index) := Philosopher(index, Forks_arr(index)'Access, Forks_arr(index + 1)'Access);
				--Philosophers_arr(index).start_dine;
			--end loop;
		Ph1.start_dine;
		Ph2.start_dine;
		Ph3.start_dine;
		Ph4.start_dine;
		Ph5.start_dine;
				
		end dining_philosophers;

end Philosophers;
