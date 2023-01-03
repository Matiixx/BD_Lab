CREATE OR REPLACE FUNCTION F_1(int) RETURNS refcursor AS ' 
DECLARE curosoby refcursor;
BEGIN
  OPEN curosoby FOR SELECT c.customer_id, i.description, ol.quantity FROM lab11.customer as c join lab11.orderinfo USING(customer_id) join lab11.orderline as ol using(orderinfo_id) join lab11.item as i using(item_id)  WHERE customer_id = $1 ;
  RETURN curosoby ;
END;
' LANGUAGE plpgsql;