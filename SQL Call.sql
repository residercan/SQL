create or replace function toplamaF(x numeric, y numeric)
returns numeric
language plpgsql
as
$$
begin

return x+y;

end
$$

select * from toplamaF(4, 6) as toplam;
