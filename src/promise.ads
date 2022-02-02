package Promise is

	type PROMISE_STATUS is (not_delivered, pending, delivered);
	
	protected type Promise is
		procedure deliver (in_value : Integer);
		function is_delivered return Boolean;
		function get_value return Integer;
		entry subscribe;
	private
		p_status : PROMISE_STATUS := not_delivered;
		value : Integer;
	end Promise;
	
	task type Listener (input_promise : access Promise) is
		entry start_listening;
		--entry listen;
	end Listener;

	procedure promise_execution;
	
end Promise;
