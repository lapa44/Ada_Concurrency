package Promise is

	-- Promise basic statuses
	type PROMISE_STATUS is (not_delivered, pending, delivered);
	
	-- Protected type which is securing concurrency
	protected type Promise is
		procedure deliver (in_value : Integer);
		function is_delivered return Boolean;
		function get_value return Integer;
		entry subscribe;
	private
		p_status : PROMISE_STATUS := not_delivered;
		value : Integer;
	end Promise;
	
	-- A task/thread which is supposed to get value from promise
	task type Listener (input_promise : access Promise) is
		entry start_listening;
	end Listener;

	-- Procedure which is executing promise example
	procedure promise_execution;
	
end Promise;
