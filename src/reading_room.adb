with Ada.Text_IO; use Ada.Text_IO;

package body Reading_Room is

   procedure open_reading_room is
   
	-- Initial value for no books is 0
	no_books : Integer :=0;
	
	-- Librarian is used to control ReadingRoom as it's director
	protected type Librarian is
		entry book_release;
		procedure after_book_release;
		entry reader_entry;
		procedure reader_exit;	
		private
		curr_Readers : Integer := 0;
		is_Writing : Boolean := False;
	end Librarian;
	
	-- Librarian implementation
	protected body Librarian is
		entry book_release when not is_Writing and curr_Readers=0 is
			begin
				is_Writing := True;
				no_books := no_books + 1;
			end book_release;
		
		procedure after_book_release is
			begin
				is_Writing := False;
			end after_book_release;
		
		entry reader_entry when not is_Writing is
			begin
				curr_Readers := curr_Readers + 1;
			end reader_entry;
		
		procedure reader_exit is 
			begin
			curr_Readers := curr_Readers - 1;
		end reader_exit;
	end Librarian;
	
	-- Librarian declaration
	director : Librarian;
	
   -- Reader and Writer implementation
	task type Reader is
		entry start_reading (idi : Integer);
	end Reader;
	
	task type Writer is
		entry start_writing (idi : Integer) ;
	end Writer;
   
	task body Reader is
		id : Integer;
	begin
		accept start_reading (idi : Integer)  do
			id := idi;
			director.reader_entry;
			Put_Line ("Reader #" & id'Image & " is reading one of "& no_Books'Image & " books.");
			director.reader_exit;
		end start_reading;
		
		loop
			delay Duration(id);
			director.reader_entry;
			Put_Line ("Reader #" & id'Image & " is reading one of "& no_Books'Image & " books.");
			director.reader_exit;
		end loop;
	end Reader;
	
	task body Writer is
		id : Integer;
	begin
		accept start_writing (idi : Integer) do
			id := idi;
			director.book_release;
			Put_Line ("Writer no " & id'Image & " wrote a book #" & no_Books'Image);
			director.after_book_release;
		end start_writing;
		
		loop
			delay Duration(id * DELAY_MULTIPLIER);
			director.book_release;
			Put_Line ("Writer no " & id'Image & " wrote a book #" & no_Books'Image);
			director.after_book_release;
		end loop;
	end Writer;
	
	-- Declaring arrays of readers and writers
	type arr_Readers is array (1 .. no_Readers) of Reader;
	type arr_Writers is array (1 .. no_Writers) of Writer;
	Readers :  arr_Readers;
	Writers : arr_Writers;
	
begin
   
	-- Initialization of writers and readers tasks
	for index in Writers'Range loop
		Writers(index).start_writing(index);
	end loop;
	
	for index in Readers'Range loop
		Readers(index).start_reading(index);
		end loop;
	end open_reading_room;
	

end Reading_Room;
