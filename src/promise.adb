with Ada.Text_IO; use Ada.Text_IO;

package body Promise is

	protected body Promise is
		procedure deliver (in_value : Integer) is
		begin
			if p_status = PROMISE_STATUS'(not_delivered) then
				p_status := PROMISE_STATUS'(pending);
				value := in_value;
				Put_Line("Delivered value: " & in_value'Image);
				p_status := PROMISE_STATUS'(delivered);
			else
				Put_Line("Cannot deliver value again.");
			end if;
		end deliver;
		
		function is_delivered return Boolean is
		begin
			return p_status = PROMISE_STATUS'(delivered);
		end is_delivered;
		
		function get_value return Integer is
		begin
			return value;
		end get_value;
		
		entry subscribe when is_delivered is
		begin
			null;
		end subscribe;
	end Promise;
	
	task body Listener is
	begin
		accept start_listening do
			Put_Line("Trying to read promised value.");
		end start_listening;
		input_promise.subscribe;
		Put_Line("Got promised value: " & input_promise.get_value'Image);
	end listener;
	
	procedure promise_execution is
		type promise_access is access Promise;
		p1  : promise_access := new Promise;
		listeners : array (1..5) of Listener(p1);
		other_listener : Listener(p1);
	begin
		for listener in listeners'Range loop
			listeners(listener).start_listening;
		end loop;
		p1.deliver(1);
		other_listener.start_listening;
	end promise_execution;
end Promise;
