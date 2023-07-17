--creating view(view is like virtual table that we used to fetch the data faster)
ALTER VIEW temp_emp
AS
SELECT * FROM orders;

--executing view temp_emp
SELECT * FROM temp_emp;

--example of nested view(one view inside another view)
ALTER VIEW nested_view
AS
SELECT * FROM temp_emp; --fetching the data from view

--executing view nested_view
SELECT * FROM nested_view;
