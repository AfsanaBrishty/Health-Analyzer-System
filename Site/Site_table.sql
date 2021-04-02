clear screen;
drop table user_health_info_site;
drop table diet_chart_table_site;
create table user_health_info_site(
ins_id number, 
BMI number,
BMR number,
BFP number
);
create table diet_chart_table_site(
Plan_id number NOT NULL,
Meal_Plan varchar2(1000) NOT NULL
);
insert into diet_chart_table_site values(1,'**Breakfast(8:00AM):Wholegrain toast with polyunsaturated margarine(2 slice),Baked beans(1/2 cup),Glass of reduced milk(250ml),
**Morning Break(11:00AM):1 medium apple,Coffee with milk(200 ml),
**Lunch(2:15PM):2 slices bread,65g roast beef,20g cheese,2 teaspoon margarine,1 cup mixed salad vegetables,
**Afternoon Break(4:30PM):Unsalted nuts(30g),200ml coffee with milk,
**Evening meal(7:00PM):Fish prepared with olive oil(100g),1cup boiled rice,Carrots(1/2),
**Evening snack(9:00PM):1cup diced fresh fruit,100g yoghurt'
);
insert into diet_chart_table_site values(2, '**Breakfast(8:00AM):Wholegrain breakfast cereal with reduced fat milk(60g cereal plus1 cup/250mL milk),Reduced fat yogurt(small tub/100g),
**Morning Break(11:00AM):Coffee with milk(200mL – small/medium size),
**Lunch(2:15PM):Sandwich with salad and chicken(2 slices bread (preferably wholemeal), 40g roast chicken,1 teaspoon margarine,1 cup salad vegetables),Apple(1 medium),
**Afternoon Break(4:30PM):Coffee with milk(200mL- small/medium size),Unsalted mixed nuts(30g-small handful),
**Evening meal(7:00PM):Pasta with lean beef mince and red kidney beans,(1 cup of cooked pasta,65g cooked lean beef mince/fist size scoop,½ onion,¼ cup kidney beans),Green salad with olive oil and vinegar dressing,
**Evening snack(9:00PM):Fruit salad (tinned or fresh)and reduced fat yoghurt(1 cup mixed fruit plus small tub/100g yoghurt)
****Drink  plenty of water throughout the day'
);

commit;
select * from user_health_info_site;
select * from diet_chart_table_site;