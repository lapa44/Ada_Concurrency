with Ada.Text_IO; use Ada.Text_IO;

package body philosophers_waiter is

	protected body Fork is
		entry grab when not owned is
		begin
			owned := True;
		end grab;
		
		procedure give_back is
		begin
			owned := False;
		end give_back;
	end Fork;
	
	protected body Waiter is
		entry try_eating when eating_philosophers < 5 is
		begin
			eating_philosophers := eating_philosophers + 1;
		end try_eating;
		
		procedure stop_eating is
		begin
			eating_philosophers := eating_philosophers - 1;
		end stop_eating;
	end Waiter;
	
	task body Philosopher is
	begin
		loop
			Put_Line ("Philosopher #" & ID'Image & " is thinking.");
			delay Duration(ID);
			Put_Line ("Philosopher #" & ID'Image & " is hungry.");
			Waiter.try_eating;
			Left.grab;
			Right.grab;
			Put_Line ("Philosopher #" & ID'Image & " is eating.");
			delay Duration(ID);
			Left.give_back;
			Right.give_back;
			Waiter.stop_eating;
		end loop;
	end Philosopher;
	
	procedure dining_room is
			Forks_arr : array (1 .. 5) of aliased Fork;
			Ph1 : Philosopher(1, Forks_arr(1)'Access, Forks_arr(2)'Access);
			Ph2 : Philosopher(2, Forks_arr(2)'Access, Forks_arr(3)'Access);
			Ph3 : Philosopher(3, Forks_arr(3)'Access, Forks_arr(4)'Access);
			Ph4 : Philosopher(4, Forks_arr(4)'Access, Forks_arr(5)'Access);
			Ph5 : Philosopher(5, Forks_arr(5)'Access, Forks_arr(1)'Access);
	begin
		Put_Line("I know that I know nothing ~Socrates");
	end dining_room;
end philosophers_waiter;
