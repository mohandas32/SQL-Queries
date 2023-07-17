create or alter function NumberIsPrime(@n int )
returns  int
as
begin
declare 
@i int =2,
@isprime int = 0
while @i < @n
    begin
        if @n % @i = 0 
            begin
                set @isprime = 1
            end
        set @i = @i+1
    end
	return @isprime
end



declare 
@i int =2,
@str varchar(max)=''
while @i<1000
begin
	if dbo.NumberIsPrime(@i) = 0
	begin
		set @str = @str + convert(varchar(100), @i)+'&'
	end
	set @i=@i+1
end
select substring(@str,0,len(@str))




